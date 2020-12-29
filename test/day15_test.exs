defmodule Day15Test do
  use ExUnit.Case
  doctest Day15

  test "works" do
    assert Day15.solve([20,0,1,11,6,3]) == 436
  end
end
