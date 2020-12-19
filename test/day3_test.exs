defmodule Day3Test do
  use ExUnit.Case
  doctest Day3

  test "counts trees from the sample pattern" do
    {:ok, content} = File.read("test/resources/day3_sample.txt")

    map = content
            |> String.split("\n", trim: true)
            |> Enum.map(&String.split(&1, "", trim: true))

    assert Day3.solve(List.flatten(map), length(List.first(map)), length(map), 3, 1) == 7
  end

  test "counts trees from the puzzle pattern" do
    {:ok, content} = File.read("test/resources/day3.txt")

    map = content
            |> String.split("\n", trim: true)
            |> Enum.map(&String.split(&1, "", trim: true))

    assert Day3.solve(List.flatten(map), length(List.first(map)), length(map), 3, 1) == 216
  end

  test "it counts multiple slopes" do
    {:ok, content} = File.read("test/resources/day3.txt")

    map = content
            |> String.split("\n", trim: true)
            |> Enum.map(&String.split(&1, "", trim: true))

    assert Day3.all_slopes(List.flatten(map), length(List.first(map)), length(map)) == 6708199680
  end
end

