defmodule Day2Test do
  use ExUnit.Case
  doctest Day2

  test "it checks the password agains the rules" do
    assert Day2.valid?("1-3 a: abcde") == true
    assert Day2.valid?("1-3 b: cdefg") == false
    assert Day2.valid?("2-9 c: ccccccccc") == true
  end

  test "it checks multiple passwords" do
    rules = ["1-3 a: abcde", "1-3 b: cdefg", "2-9 c: ccccccccc"]
    assert Day2.solve(rules, &Day2.valid?/1) == 2
  end

  test "it checks passwords from file" do
    {:ok, content} = File.read("test/resources/day2.txt")
    rules = content |> String.split("\n", trim: true)

    assert Day2.solve(rules, &Day2.valid?/1) == 569
  end

  test "it checks the password agains the actual rules" do
    assert Day2.valid2?("1-3 a: abcde") == true
    assert Day2.valid2?("1-3 b: cdefg") == false
    assert Day2.valid2?("2-9 c: ccccccccc") == false
  end

  test "it checks passwords from file against actual rules" do
    {:ok, content} = File.read("test/resources/day2.txt")
    rules = content |> String.split("\n", trim: true)

    assert Day2.solve(rules, &Day2.valid2?/1) == 346
  end
end
