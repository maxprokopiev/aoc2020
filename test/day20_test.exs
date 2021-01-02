defmodule Day20Test do
  use ExUnit.Case

  # test "works" do
  #   a = [
  #     ["x", "x", "x", "x", "x"],
  #     ["x", "a", "b", "c", "x"],
  #     ["x", "d", "e", "f", "x"],
  #     ["x", "g", "h", "i", "x"],
  #     ["x", "x", "x", "x", "x"],
  #   ]
  # end

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

  test "finds roughness for sample input" do
    {:ok, content} = File.read("test/resources/day20_sample.txt")
    raw_tiles = String.split(content, "\n\n", trim: true)

    raw_mapped = Enum.map raw_tiles, fn raw_tile_with_id ->
      [raw_id | raw_tile] = String.split(raw_tile_with_id, "\n", trim: true)
      id = raw_id |> String.replace(~r/[^\d]/, "") |> String.to_integer
      tile = Enum.map(raw_tile, fn row -> String.graphemes(row) end)
      {id, tile}
    end

    tiles = raw_mapped |> Enum.into(%{})

    assert Day20.solve2(tiles) == 273
  end

  test "finds roughness for puzzle input" do
    {:ok, content} = File.read("test/resources/day20.txt")
    raw_tiles = String.split(content, "\n\n", trim: true)

    raw_mapped = Enum.map raw_tiles, fn raw_tile_with_id ->
      [raw_id | raw_tile] = String.split(raw_tile_with_id, "\n", trim: true)
      id = raw_id |> String.replace(~r/[^\d]/, "") |> String.to_integer
      tile = Enum.map(raw_tile, fn row -> String.graphemes(row) end)
      {id, tile}
    end

    tiles = raw_mapped |> Enum.into(%{})

    assert Day20.solve2(tiles) == 2190
  end
end
