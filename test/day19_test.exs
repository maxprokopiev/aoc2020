defmodule Day19Test do
  use ExUnit.Case
  doctest Day19

  test "works" do
    {:ok, content} = File.read("test/resources/day19_sample.txt")
    [rules, messages] = content |> String.split("\n\n", trim: true)

    assert Day19.solve(String.split(rules, "\n"), String.split(messages, "\n")) == 2
  end

  test "from file" do
    {:ok, content} = File.read("test/resources/day19.txt")
    [rules, messages] = content |> String.split("\n\n", trim: true)

    assert Day19.solve(String.split(rules, "\n"), String.split(messages, "\n")) == 216
  end

  test "sample 2 file" do
    {:ok, content} = File.read("test/resources/day19_sample2.txt")
    [rules, messages] = content |> String.split("\n\n", trim: true)

    assert Day19.solve(String.split(rules, "\n"), String.split(messages, "\n")) == 3
  end

  test "sample 3 file" do
    {:ok, content} = File.read("test/resources/day19_sample3.txt")
    [rules, messages] = content |> String.split("\n\n", trim: true)

    assert Day19.solve(String.split(rules, "\n"), String.split(messages, "\n")) == 12
  end

  test "part 2 file" do
    {:ok, content} = File.read("test/resources/day19_part2.txt")
    [rules, messages] = content |> String.split("\n\n", trim: true)

    assert Day19.solve(String.split(rules, "\n"), String.split(messages, "\n")) == 400
  end
end
