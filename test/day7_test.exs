defmodule Day7Test do
  use ExUnit.Case
  doctest Day7

  test "parses things" do
    Day7.build_graph([
      "dim chartreuse bags contain 2 wavy teal bags, 5 mirrored black bags, 5 mirrored bronze bags, 4 muted lavender bags."
    ])
  end

  test "counts bags from rules" do
    rules = [
      "light red bags contain 1 bright white bag, 2 muted yellow bags.",
      "dark orange bags contain 3 bright white bags, 4 muted yellow bags.",
      "bright white bags contain 1 shiny gold bag.",
      "muted yellow bags contain 2 shiny gold bags, 9 faded blue bags.",
      "shiny gold bags contain 1 dark olive bag, 2 vibrant plum bags.",
      "dark olive bags contain 3 faded blue bags, 4 dotted black bags.",
      "vibrant plum bags contain 5 faded blue bags, 6 dotted black bags.",
      "faded blue bags contain no other bags.",
      "dotted black bags contain no other bags."
    ]

    assert Day7.solve(rules) == 4
    assert Day7.solve_2(rules) == 32
  end

  test "counts bags from other set of rules" do
    rules = [
      "shiny gold bags contain 2 dark red bags.",
      "dark red bags contain 2 dark orange bags.",
      "dark orange bags contain 2 dark yellow bags.",
      "dark yellow bags contain 2 dark green bags.",
      "dark green bags contain 2 dark blue bags.",
      "dark blue bags contain 2 dark violet bags.",
      "dark violet bags contain no other bags."
    ]

    assert Day7.solve_2(rules) == 126
  end

  test "counts bags from file" do
    {:ok, content} = File.read("test/resources/day7.txt")
    input = content |> String.split("\n", trim: true)

    assert Day7.solve(input) == 229
    assert Day7.solve_2(input) == 6683
  end
end
