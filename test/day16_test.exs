defmodule Day16Test do
  use ExUnit.Case
  doctest Day16

  test "works" do
    {:ok, content} = File.read("test/resources/day16_sample.txt")
    [ranges, _, tickets] = content |> String.split("\n\n", trim: true)

    assert Day16.solve(ranges, tickets) == 71
  end

  test "calculates the ticket scanning rate" do
    {:ok, content} = File.read("test/resources/day16.txt")
    [ranges, _, tickets] = content |> String.split("\n\n", trim: true)

    assert Day16.solve(ranges, tickets) == 26009
  end

  test "determines fields order" do
    {:ok, content} = File.read("test/resources/day16.txt")
    [ranges, ticket, tickets] = content |> String.split("\n\n", trim: true)

    assert Day16.solve2(ranges, ticket, tickets) == 589685618167
  end
end
