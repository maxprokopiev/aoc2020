defmodule Day24Test do
  use ExUnit.Case

  test "sample" do
    {:ok, content} = File.read("test/resources/day24_sample.txt")
    input = content |> String.split("\n", trim: true)

    assert Day24.solve(input) == 10
  end

  test "puzzle" do
    {:ok, content} = File.read("test/resources/day24.txt")
    input = content |> String.split("\n", trim: true)

    assert Day24.solve(input) == 300
  end
end
