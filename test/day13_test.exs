defmodule Day13Test do
  use ExUnit.Case
  doctest Day13

  test "finds earliest bus" do
    timestamp = 939
    buses = [7,13,59,31,19]

    assert Day13.solve(buses, timestamp) == 295
  end

  test "finds earliest bus from file" do
    {:ok, content} = File.read("test/resources/day13.txt")
    [timestamp, buses] = content |> String.split("\n", trim: true)

    assert Day13.solve(
      buses |> String.split(",", trim: true) |> Enum.filter(fn e -> e != "x" end) |> Enum.map(fn e -> String.to_integer(e) end),
      String.to_integer(timestamp)
    ) == 246
  end

  test "finds the timestamp" do
    buses = [{7, 0}, {13, 1}, {59, 4}, {31, 6}, {19, 7}]

    assert Day13.solve2(buses) == 1068781
  end

  test "finds the timestamp from file" do
    {:ok, content} = File.read("test/resources/day13.txt")
    [_, buses] = content |> String.split("\n", trim: true)

    input = buses |> String.split(",", trim: true) |> Enum.with_index |> Enum.filter(fn {id, _} -> id != "x" end) |> Enum.map(fn {id, i} -> {String.to_integer(id), i} end)

    assert Day13.solve2(input) == 939490236001473
  end
end
