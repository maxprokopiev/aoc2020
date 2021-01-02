defmodule Day20Test do
  use ExUnit.Case

  test "works" do
    a = [
      ["a", "b", "c"],
      ["d", "e", "f"],
      ["g", "h", "i"]
    ]
    IO.inspect Day20.rot90(a) |> Day20.flip_h
  end

  test "finds corners for sample input" do
    {:ok, content} = File.read("test/resources/day20_sample.txt")
    raw_tiles = String.split(content, "\n\n", trim: true)

    raw_mapped = Enum.map raw_tiles, fn raw_tile_with_id ->
      [raw_id | raw_tile] = String.split(raw_tile_with_id, "\n", trim: true)
      id = raw_id |> String.replace(~r/[^\d]/, "") |> String.to_integer
      tile = Enum.map(raw_tile, fn row -> String.graphemes(row) end)
      {id, tile}
    end

    tiles = raw_mapped |> Enum.into(%{})

    assert Day20.solve(tiles) == 20899048083289
  end

  test "finds corners for puzzle input" do
    {:ok, content} = File.read("test/resources/day20.txt")
    raw_tiles = String.split(content, "\n\n", trim: true)

    raw_mapped = Enum.map raw_tiles, fn raw_tile_with_id ->
      [raw_id | raw_tile] = String.split(raw_tile_with_id, "\n", trim: true)
      id = raw_id |> String.replace(~r/[^\d]/, "") |> String.to_integer
      tile = Enum.map(raw_tile, fn row -> String.graphemes(row) end)
      {id, tile}
    end

    tiles = raw_mapped |> Enum.into(%{})

    assert Day20.solve(tiles) == 15006909892229
  end
end

# 1951    2311    3079
# 2729    1427    2473
# 2971    1489    1171
