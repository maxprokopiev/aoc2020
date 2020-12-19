defmodule Day6Test do
  use ExUnit.Case
  doctest Day6

  test "count answers from the sample input" do
    {:ok, content} = File.read("test/resources/day6_sample.txt")

    answers = content
                  |> String.split("\n\n")
                  |> Enum.map(&String.split(&1, "\n", trim: true))

    assert Day6.solve(answers) == 11
  end

  test "count answers from the puzzle input" do
    {:ok, content} = File.read("test/resources/day6.txt")

    answers = content
                  |> String.split("\n\n")
                  |> Enum.map(&String.split(&1, "\n", trim: true))

    assert Day6.solve(answers) == 6911
  end

  test "count answers from the sample input for part 2" do
    {:ok, content} = File.read("test/resources/day6_sample.txt")

    answers = content
                  |> String.split("\n\n")
                  |> Enum.map(&String.split(&1, "\n", trim: true))

    assert Day6.solve_2(answers) == 6
  end

  test "count answers from the puzzle input for part 2" do
    {:ok, content} = File.read("test/resources/day6.txt")

    answers = content
                  |> String.split("\n\n")
                  |> Enum.map(&String.split(&1, "\n", trim: true))

    assert Day6.solve_2(answers) == 3473
  end
end
