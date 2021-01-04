defmodule Day24 do
  @coords %{
    "e" => {1, -1, 0},
    "w" => {-1, 1, 0},
    "nw" => {0, 1, -1},
    "ne" => {1, 0, -1},
    "sw" => {-1, 0, 1},
    "se" => {0, -1, 1}
  }

  def solve(input) do
    paths = Enum.map input, fn s -> prepare_paths(s) end

    f1 = Enum.reduce paths, Map.put(%{}, {0, 0, 0}, false), fn path, floor ->
      coords = traverse({0, 0, 0}, path)
      Map.put(floor, coords, !floor[coords])
    end

    Enum.count Map.values(f1), fn t -> t end
  end

  def solve2(input) do
    paths = Enum.map input, fn s -> prepare_paths(s) end

    f1 = Enum.reduce paths, Map.put(%{}, {0, 0, 0}, false), fn path, floor ->
      coords = traverse({0, 0, 0}, path)
      Map.put(floor, coords, !floor[coords])
    end

    f2 = Enum.reduce 1..100, f1, fn _, nf ->
      iterate(nf)
    end
    Enum.count Map.values(f2), fn t -> t end
  end

  def iterate(floor) do
    extended_floor = Enum.reduce Map.keys(floor), floor, fn {x, y, z}, f ->
      ns = Enum.map Map.values(@coords), fn {dx, dy, dz} -> {x + dx, y + dy, z + dz} end
      Enum.reduce ns, f, fn nb, nf ->
        if nf[nb] == nil, do: Map.put(nf, nb, false), else: nf
      end
    end

    r = Enum.map extended_floor, fn {coords, black} ->
      n = count_black_neighbours(extended_floor, coords)
      v = case black do
        true -> !((n == 0) || (n > 2))
        false -> n == 2
      end

      {coords, v}
    end
    Enum.into(r, %{})
  end

  def count_black_neighbours(floor, coords = {x, y, z}) do
    ns = Enum.map Map.values(@coords), fn {dx, dy, dz} -> {x + dx, y + dy, z + dz} end
    Enum.count ns, fn c -> floor[c] == true end
  end

  def prepare_paths(s, i \\ 0, paths \\ []) do
    if i == String.length(s) do
      paths
    else
      next = String.at(s, i)
      cond do
        next in ["e", "w"] ->
          prepare_paths(s, i + 1, paths ++ [next])
        next in ["s", "n"] ->
          prepare_paths(s, i + 2, paths ++ [next <> String.at(s, i + 1)])
      end
    end
  end

  def traverse(coords, path) do
    Enum.reduce path, coords, fn dir, {x, y, z} ->
      {dx, dy, dz} = @coords[dir]
      {x + dx, y + dy, z + dz}
    end
  end
end
