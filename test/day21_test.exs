defmodule Day21Test do
  use ExUnit.Case

  test "sample" do
    {:ok, content} = File.read("test/resources/day21_sample.txt")
    goods = String.split(content, "\n", trim: true)

    assert Day21.solve(goods) == 5
  end

  test "sample part2" do
    {:ok, content} = File.read("test/resources/day21_sample.txt")
    goods = String.split(content, "\n", trim: true)

    assert Day21.solve2(goods) == "mxmxvkd,sqjhc,fvjkl"
  end

  test "file" do
    {:ok, content} = File.read("test/resources/day21.txt")
    goods = String.split(content, "\n", trim: true)

    assert Day21.solve(goods) == 2798
  end

  test "file part2" do
    {:ok, content} = File.read("test/resources/day21.txt")
    goods = String.split(content, "\n", trim: true)

    assert Day21.solve2(goods) == "gbt,rpj,vdxb,dtb,bqmhk,vqzbq,zqjm,nhjrzzj"
  end
end
