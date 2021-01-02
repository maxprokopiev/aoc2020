defmodule Day20 do
  def solve(tiles) do
    size = get_dimensions(tiles)

    versions = Enum.reduce tiles, %{}, fn {tile_id, tile}, acc ->
      Map.put(acc, tile_id, rotations(tile))
    end

    corner_tiles = find_valid_tiles(tiles, versions, [:top, :left])

    tile_id = hd(Map.keys(corner_tiles))
    tile = hd(corner_tiles[tile_id])

    jigsaw = build(
      Map.put(prepare_jigsaw(tiles), {0, 0}, {tile_id, tile}),
      size,
      List.delete(Map.keys(tiles), tile_id),
      versions
    )
    Enum.reduce [jigsaw[{0, 0}], jigsaw[{0, size - 1}], jigsaw[{size - 1, 0}], jigsaw[{size - 1, size - 1}]], 1, fn {tile_id, _}, acc -> tile_id * acc end
  end

  def prepare_jigsaw(tiles) do
    dimensions = get_dimensions(tiles)

    for i <- 0..(dimensions - 1), j <- 0..(dimensions - 1), into: %{} do
      possibilities = Enum.reduce tiles, [], fn {id, _}, acc ->
        acc ++ [id]
      end
      {{i, j}, nil}
    end
  end

  def build(original_jigsaw, size, original_tile_ids, versions) do
    Enum.reduce_while Stream.cycle([0]), {original_jigsaw, original_tile_ids, 0}, fn _, {jigsaw, tile_ids, found} ->
      if Enum.all?(jigsaw, fn {_, v} -> v != nil end) do
        {:halt, jigsaw}
      else
        r = Enum.reduce Map.keys(jigsaw), {jigsaw, tile_ids, found}, fn {i, j}, {new_jigsaw, new_tile_ids, acc} ->
          if new_jigsaw[{i, j}] do
            {jigsaw3, tile_ids3} = find_neighbours(new_jigsaw, i, j, new_tile_ids, versions, size)
            {jigsaw3, tile_ids3, acc + 1}
          else
            {new_jigsaw, new_tile_ids, acc}
          end
        end
        {:cont, r}
      end
    end
  end

  def find_neighbours(original_jigsaw, i, j, original_tile_ids, versions, size) do
    {tile_id, tile} = original_jigsaw[{i, j}]
    Enum.reduce [:top, :right, :bottom, :left], {original_jigsaw, List.delete(original_tile_ids, tile_id)}, fn dir, {jigsaw, tile_ids} ->
      case dir do
        :top when i - 1 >= 0 ->
          if jigsaw[{i - 1, j}] do
            {jigsaw, tile_ids}
          else
            {neighbour_tile_id, neighbour_tile} = find_neighbour(versions, tile_ids, tile, :top)
            {Map.put(jigsaw, {i - 1, j}, {neighbour_tile_id, neighbour_tile}), List.delete(tile_ids, neighbour_tile_id)}
          end
        :right when j + 1 < size ->
          if jigsaw[{i, j + 1}] do
            {jigsaw, tile_ids}
          else
            {neighbour_tile_id, neighbour_tile} = find_neighbour(versions, tile_ids, tile, :right)
            {Map.put(jigsaw, {i, j + 1}, {neighbour_tile_id, neighbour_tile}), List.delete(tile_ids, neighbour_tile_id)}
          end
        :bottom when i + 1 < size ->
          if jigsaw[{i + 1, j}] do
            {jigsaw, tile_ids}
          else
            {neighbour_tile_id, neighbour_tile} = find_neighbour(versions, tile_ids, tile, :bottom)
            {Map.put(jigsaw, {i + 1, j}, {neighbour_tile_id, neighbour_tile}), List.delete(tile_ids, neighbour_tile_id)}
          end
        :left when j - 1 >= 0 ->
          if jigsaw[{i, j - 1}] do
            {jigsaw, tile_ids}
          else
            {neighbour_tile_id, neighbour_tile} = find_neighbour(versions, tile_ids, tile, :left)
            {Map.put(jigsaw, {i, j - 1}, {neighbour_tile_id, neighbour_tile}), List.delete(tile_ids, neighbour_tile_id)}
          end
        _ ->
          {jigsaw, tile_ids}
      end
    end
  end

  def find_neighbour(versions, tile_ids, tile, dir) do
    Enum.reduce tile_ids, {}, fn tile_id, acc ->
      valid_tiles = Enum.filter versions[tile_id], fn other_tile -> fits?(tile, other_tile, dir) end
      if valid_tiles == [], do: acc, else: {tile_id, hd(valid_tiles)}
    end
  end

  def find_valid_tiles(tiles, versions, dirs) do
    tile_ids = Map.keys(tiles)
    Enum.reduce tile_ids, %{}, fn tile_id, acc ->
      version = Enum.find versions[tile_id], fn tile ->
        other_tile_ids = List.delete(tile_ids, tile_id)
        Enum.all? other_tile_ids, fn other_tile_id ->
          Enum.all?(dirs, fn dir -> cant_use?(tile, versions[other_tile_id], dir) end)
        end
      end
      if version do
        Map.put(acc, tile_id, [version])
      else
        acc
      end
    end
  end

  def cant_use?(tile, versions, direction) do
    Enum.all?(versions, fn other_tile -> !fits?(tile, other_tile, direction) end)
  end

  def print(jigsaw, dimensions \\ 3) do
    for i <- 0..(dimensions - 1), into: [] do
      for j <- 0..(dimensions - 1), into: [] do
        if jigsaw[{i,j}] do
          {tile_id, _} = jigsaw[{i, j}]
          Integer.to_string(tile_id)
        else
          "-"
        end
      end
    end
  end

  def discard_picked(jigsaw, coords_to_remove, pick) do
    Enum.reduce Map.keys(jigsaw), jigsaw, fn coords, new_jigsaw ->
      if coords == coords_to_remove do
        Map.put(new_jigsaw, coords, List.delete(new_jigsaw[coords], pick))
      else
        new_jigsaw
      end
    end
  end

  def remove_picked(jigsaw, coords_to_skip, pick) do
    Enum.reduce Map.keys(jigsaw), jigsaw, fn coords, new_jigsaw ->
      if coords == coords_to_skip do
        new_jigsaw
      else
        Map.put(new_jigsaw, coords, List.delete(new_jigsaw[coords], pick))
      end
    end
  end

  def reduce_neighbours(pick, jigsaw, directions) do
    r = Enum.reduce_while directions, jigsaw, fn {dir, coords}, new_jigsaw ->
      valid_tiles = Enum.filter new_jigsaw[coords], fn tile -> fits?(pick, tile, dir) end

      if valid_tiles == [] do
        {:halt, :error}
      else
        {:cont, Map.put(new_jigsaw, coords, valid_tiles)}
      end
    end

    if r == :error, do: {:error, jigsaw}, else: {:ok, r}
  end

  def get_directions(jigsaw, i, j) do
    Enum.filter [{:top, {i - 1, j}}, {:left, {i, j - 1}}, {:right, {i, j + 1}}, {:bottom, {i + 1, j}}], fn {_, coords} -> jigsaw[coords] != nil end
  end

  # tile2
  # -----
  # tile1
  def fits_top?(tile1, tile2) do
    List.last(tile2) == List.first(tile1)
  end

  # tile1 | tile2
  def fits_right?(tile1, tile2) do
    List.first(rot90(tile1)) == List.first(rot90(tile2) |> flip_h)
  end

  def fits?(tile1, tile2, direction) do
    case direction do
      :top ->
        fits_top?(tile1, tile2)
      :right ->
        fits_right?(tile1, tile2)
      :bottom ->
        fits_top?(tile2, tile1)
      :left ->
        fits_right?(tile2, tile1)
    end
  end

  def get_dimensions(tiles), do: trunc(:math.sqrt(length(Map.keys(tiles))))

  def rotations(m) do
    flipped_v = flip_v(m)
    flipped_h = flip_h(m)

    [
      m,        flipped_v,        flipped_h,
      rot90(m), rot90(flipped_v), rot90(flipped_h),
      rot180(m),
      rot270(m)
    ]
  end

  def flip_v(m) do
    Enum.map m, fn row -> Enum.reverse(row) end
  end

  def flip_h(m) do
    Enum.reverse(m)
  end

  def rot90(m) do
    for i <- 0..(length(m) - 1), into: [] do
      row = Enum.at(m, i)
      for j <- 0..(length(row) - 1), into: [] do
        Enum.at(Enum.at(m, j), length(m) - i - 1)
      end
    end
  end

  def rot180(m), do: m |> rot90 |> rot90
  def rot270(m), do: m |> rot180 |> rot90
end
