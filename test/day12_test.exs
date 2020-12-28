defmodule Day12Test do
  use ExUnit.Case
  doctest Day12

  test "finds a manhattan distance on the sample input" do
    directions = ["F10", "N3", "F7", "R90", "F11"]

    assert Day12.solve(directions) == 25
  end

  test "finds a manhattan distance on the puzzle input" do
    {:ok, content} = File.read("test/resources/day12.txt")

    directions = content |> String.split("\n", trim: true)

    assert Day12.solve(directions) == 590
  end

  test "finds a manhattan distance relative to the waypoint on the sample input" do
    directions = ["F10", "N3", "F7", "R90", "F11"]

    assert Day12.solve2(directions) == 286
  end

  test "finds a manhattan distance relative to the waypoint on the puzzle input" do
    {:ok, content} = File.read("test/resources/day12.txt")

    directions = content |> String.split("\n", trim: true)

    assert Day12.solve2(directions) == 42013
  end
end
