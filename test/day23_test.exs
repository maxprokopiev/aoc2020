defmodule Day23Test do
  use ExUnit.Case

  test "sample" do
    assert Day23.solve("389125467") == "67384529"
  end

  test "puzzle" do
    assert Day23.solve("186524973") == "45983627"
  end

  test "sample part2" do
    assert Day23.solve2("389125467") == 149245887792
  end
end
