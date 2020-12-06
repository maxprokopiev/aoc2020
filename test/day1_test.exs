defmodule Day1Test do
  use ExUnit.Case
  doctest Day1

  test "it works with sample input" do
    input = [979, 366, 299, 675, 1456, 1721]
    assert Day1.solve(input) == 514579
  end

  test "it works with the input from the file" do
    {:ok, content} = File.read("test/resources/day1.txt")
    input = content |> String.split("\n", trim: true) |> Enum.map(&String.to_integer/1)
    assert Day1.solve(input) == 902451
  end

  test "it works with sample input from part 2" do
    input = [979, 366, 299, 675, 1456, 1721]
    assert Day1.solve2(input) == 241861950
  end

  test "it works with the input from the file from part 2" do
    {:ok, content} = File.read("test/resources/day1.txt")
    input = content |> String.split("\n", trim: true) |> Enum.map(&String.to_integer/1)
    assert Day1.solve2(input) == 85555470
  end
end
