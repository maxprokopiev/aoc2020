defmodule Day9Test do
  use ExUnit.Case
  doctest Day9

  test "finds first non-matching number" do
    data = [35, 20, 15, 25, 47, 40, 62, 55, 65, 95, 102, 117, 150, 182, 127, 219, 299, 277, 309, 576]
    assert Day9.solve(data, 5) == 127
  end

  test "finds first non-matching number from the file" do
    {:ok, content} = File.read("test/resources/day9.txt")
    input = content |> String.split("\n", trim: true) |> Enum.map(fn e -> String.to_integer(e) end)

    assert Day9.solve(input, 25) == 31161678
  end

  test "it finds the contiguous set of numbers" do
    data = [35, 20, 15, 25, 47, 40, 62, 55, 65, 95, 102, 117, 150, 182, 127, 219, 299, 277, 309, 576]
    assert Day9.solve2(data, 127) == 62
  end

  test "it finds the contiguous set of numbers reading from file" do
    {:ok, content} = File.read("test/resources/day9.txt")
    input = content |> String.split("\n", trim: true) |> Enum.map(fn e -> String.to_integer(e) end)

    assert Day9.solve2(input, 31161678) == 5453868
  end
end
