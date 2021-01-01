defmodule Day18Test do
  use ExUnit.Case
  doctest Day18

  # test "works" do
  #   assert Day18.solve("1 + 2 * 3 + 4 * 5 + 6") == 71
  #   assert Day18.solve("2 * 3 + (4 * 5)") == 26
  #   assert Day18.solve("5 + (8 * 3 + 9 + 3 * 4 * 3)") == 437
  #   assert Day18.solve("5 * 9 * (7 * 3 * 3 + 9 * 3 + (8 + 6 * 4))") == 12240
  #   assert Day18.solve("((2 + 4 * 9) * (6 + 9 * 8 + 6) + 6) + 2 + 4 * 2") == 13632
  # end

  test "reads from file" do
    {:ok, content} = File.read("test/resources/day18.txt")
    sum = content |> String.split("\n", trim: true) |> Enum.map(&Day18.solve/1) |> Enum.sum
    # assert sum == 98621258158412 old rules
    assert sum == 241216538527890
  end

  test "works with new rules" do
    assert Day18.solve("1 + 2 * 3 + 4 * 5 + 6") == 231
    assert Day18.solve("1 + (2 * 3) + (4 * (5 + 6))") == 51
    assert Day18.solve("2 * 3 + (4 * 5)") == 46
    assert Day18.solve("5 + (8 * 3 + 9 + 3 * 4 * 3)") == 1445
    assert Day18.solve("5 * 9 * (7 * 3 * 3 + 9 * 3 + (8 + 6 * 4))") == 669060
    assert Day18.solve("((2 + 4 * 9) * (6 + 9 * 8 + 6) + 6) + 2 + 4 * 2") == 23340
  end
end
