defmodule Day4Test do
  use ExUnit.Case
  doctest Day4

  test "counts valid passports from the sample input" do
    {:ok, content} = File.read("test/resources/day4_sample.txt")

    passports = content
                  |> String.split("\n\n")
                  |> Enum.map(&String.split(&1, ~r{(\s|\n)}, trim: true))

    assert Day4.solve(passports) == 2

    {:ok, content} = File.read("test/resources/day4_invalid.txt")

    passports = content
                  |> String.split("\n\n")
                  |> Enum.map(&String.split(&1, ~r{(\s|\n)}, trim: true))

    assert Day4.solve(passports) == 0

    {:ok, content} = File.read("test/resources/day4_valid.txt")

    passports = content
                  |> String.split("\n\n")
                  |> Enum.map(&String.split(&1, ~r{(\s|\n)}, trim: true))

    assert Day4.solve(passports) == 4
  end

  test "counts valid passports from the puzzle input" do
    {:ok, content} = File.read("test/resources/day4.txt")

    passports = content
                  |> String.split("\n\n")
                  |> Enum.map(&String.split(&1, ~r{(\s|\n)}, trim: true))

    assert Day4.solve(passports) == 123
  end
end
