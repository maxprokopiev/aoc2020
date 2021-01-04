defmodule Day25Test do
  use ExUnit.Case

  test "sample" do
    assert Day25.solve(5764801, 17807724) == 14897079
  end

  test "puzzle" do
    assert Day25.solve(6270530, 14540258) == 16311885
  end
end
