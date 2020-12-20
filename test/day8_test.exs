defmodule Day8Test do
  use ExUnit.Case
  doctest Day8

  test "detects the last value before the loop" do
    program = [
      "nop +0",
      "acc +1",
      "jmp +4",
      "acc +3",
      "jmp -3",
      "acc -99",
      "acc +1",
      "jmp -4",
      "acc +6"
    ]

    assert Day8.solve(program) == 5
  end

  test "detects the last value before the loop reading instructions from file" do
    {:ok, content} = File.read("test/resources/day8.txt")
    input = content |> String.split("\n", trim: true)

    assert Day8.solve(input) == 1475
  end

  test "fixes the infinite loop" do
    program = [
      "nop +0",
      "acc +1",
      "jmp +4",
      "acc +3",
      "jmp -3",
      "acc -99",
      "acc +1",
      "jmp -4",
      "acc +6"
    ]

    assert Day8.solve_2(program) == 8
  end

  test "fixes the ininite loop from file" do
    {:ok, content} = File.read("test/resources/day8.txt")
    input = content |> String.split("\n", trim: true)

    assert Day8.solve_2(input) == 1270
  end
end
