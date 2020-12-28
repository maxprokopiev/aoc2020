defmodule Day11Test do
  use ExUnit.Case
  doctest Day11

  test "finds stable seat arrangement based on sample input" do
    {:ok, content} = File.read("test/resources/day11_sample.txt")

    map = content
            |> String.split("\n", trim: true)
            |> Enum.map(&String.split(&1, "", trim: true))

    assert Day11.solve(map) == 37
  end

  test "finds stable seat arrangement based challenge input" do
    {:ok, content} = File.read("test/resources/day11.txt")

    map = content
            |> String.split("\n", trim: true)
            |> Enum.map(&String.split(&1, "", trim: true))

    assert Day11.solve(map) == 2204
  end

  test "finds stable seat arrangement based on sample input and new rules" do
    {:ok, content} = File.read("test/resources/day11_sample.txt")

    map = content
            |> String.split("\n", trim: true)
            |> Enum.map(&String.split(&1, "", trim: true))

    assert Day11.solve2(map) == 26
  end

  test "finds stable seat arrangement based on challenge input and new rules" do
    {:ok, content} = File.read("test/resources/day11.txt")

    map = content
            |> String.split("\n", trim: true)
            |> Enum.map(&String.split(&1, "", trim: true))

    assert Day11.solve2(map) == 1986
  end
end
