defmodule Day10Test do
  use ExUnit.Case
  doctest Day10

  test "finds differences in joltage on sample input" do
    input = [16, 10, 15, 5, 1, 11, 7, 19, 6, 12, 4]
    assert Day10.solve(input) == 7 * 5

    other_input = [28, 33, 18, 42, 31, 14, 46, 20, 48, 47, 24, 23, 49, 45, 19, 38, 39, 11, 1, 32, 25, 35, 8, 17, 7, 9, 4, 2, 34, 10, 3]
    assert Day10.solve(other_input) == 22 * 10
  end

  test "finds differences in joltage" do
    {:ok, content} = File.read("test/resources/day10.txt")
    input = content |> String.split("\n", trim: true) |> Enum.map(fn e -> String.to_integer(e) end)

    assert Day10.solve(input) == 2475
  end

  test "finds all the ways" do
    input = [16, 10, 15, 5, 1, 11, 7, 19, 6, 12, 4]
    assert Day10.solve2(input) == 8

    other_input = [28, 33, 18, 42, 31, 14, 46, 20, 48, 47, 24, 23, 49, 45, 19, 38, 39, 11, 1, 32, 25, 35, 8, 17, 7, 9, 4, 2, 34, 10, 3]
    assert Day10.solve2(other_input) == 19208
  end

  test "finds all the ways from file" do
    {:ok, content} = File.read("test/resources/day10.txt")
    input = content |> String.split("\n", trim: true) |> Enum.map(fn e -> String.to_integer(e) end)

    assert Day10.solve2(input) == 442136281481216
  end
end
