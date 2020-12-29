defmodule Day14Test do
  use ExUnit.Case
  doctest Day14

  test "works" do
    input = [
      "mask = XXXXXXXXXXXXXXXXXXXXXXXXXXXXX1XXXX0X",
      "mem[8] = 11",
      "mem[7] = 101",
      "mem[8] = 0"
    ]

    assert Day14.solve(input) == 165
  end

  test "works with version 2" do
    input = [
      "mask = 000000000000000000000000000000X1001X",
      "mem[42] = 100",
      "mask = 00000000000000000000000000000000X0XX",
      "mem[26] = 1"
    ]

    assert Day14.solve2(input) == 208
  end

  test "finds sum of value in memory" do
    {:ok, content} = File.read("test/resources/day14.txt")

    instructions = content |> String.split("\n", trim: true)

    assert Day14.solve(instructions) == 11926135976176
  end

  test "finds sum of value in memory with version 2" do
    {:ok, content} = File.read("test/resources/day14.txt")

    instructions = content |> String.split("\n", trim: true)

    assert Day14.solve2(instructions) == 4330547254348
  end
end
