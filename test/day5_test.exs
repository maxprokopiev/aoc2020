defmodule Day5Test do
  use ExUnit.Case
  doctest Day5

  test "decodes sample boarding passes" do
    assert Day5.solve("FBFBBFFRLR") == [44, 5, 357]
    assert Day5.solve("BFFFBBFRRR") == [70, 7, 567]
    assert Day5.solve("FFFBBBFRRR") == [14, 7, 119]
    assert Day5.solve("BBFFBBFRLL") == [102, 4, 820]
  end

  test "decodes boarding passes from file" do
    {:ok, content} = File.read("test/resources/day5.txt")
    input = content |> String.split("\n", trim: true)

    assert Enum.max(Enum.map input, fn pass -> Enum.at(Day5.solve(pass), 2) end) == 963
  end

  test "finds the seat" do
    {:ok, content} = File.read("test/resources/day5.txt")
    input = content |> String.split("\n", trim: true)

    ids = Enum.map input, fn pass -> Enum.at(Day5.solve(pass), 2) end
    Enum.to_list(0..963) -- ids
  end
end
