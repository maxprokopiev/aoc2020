defmodule Day17 do
  def iterate(map) do
    Enum.reduce map, %{}, fn {coords, value}, new_map ->
      ns = perms(coords)
      r1 = update_cube(map, new_map, coords, value, ns)

      r2 = Enum.reduce ((ns -- Map.keys(map)) -- Map.keys(new_map)), %{}, fn new_coords, new_map2 ->
        new_ns = perms(new_coords)
        update_cube(map, new_map2, new_coords, false, new_ns)
      end

      Map.merge(r1, r2)
    end
  end

  def update_cube(map, new_map, coords, value, ns) do
    active_ns = Enum.count(ns -- [coords], fn n -> map[n] == true end)

    if value do
      Map.put(new_map, coords, (active_ns == 2) || (active_ns == 3))
    else
      Map.put(new_map, coords, active_ns == 3)
    end
  end

  def convert(section) do
    Enum.reduce Enum.with_index(section), %{}, fn {row, x}, map ->
      r = Enum.reduce Enum.with_index(row), %{}, fn {cube, y}, map2 ->
        case cube do
          "." ->
            Map.put(map2, [x, y, 0, 0], false)
          "#" ->
            Map.put(map2, [x, y, 0, 0], true)
        end
      end
      Map.merge(map, r)
    end
  end

  def perms(coords) do
    [x | xs] = coords
    variants = [[x - 1], [x], [x + 1]]

    if xs == [] do
      variants
    else
      ps = perms(xs)
      Enum.flat_map variants, fn c ->
        Enum.flat_map ps, fn p ->
          [c ++ p]
        end
      end
    end
  end
end
