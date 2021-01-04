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

    new_floor = Enum.reduce paths, Map.put(%{}, {0, 0, 0}, false), fn path, floor ->
      coords = traverse({0, 0, 0}, path)
      Map.put(floor, coords, !floor[coords])
    end

    Enum.count Map.values(new_floor), fn t -> t end
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
