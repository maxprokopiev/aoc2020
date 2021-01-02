defmodule Day22Test do
  use ExUnit.Case

  test "sample" do
    {:ok, content} = File.read("test/resources/day22_sample.txt")
    [p1, p2] = String.split(content, "\n\n", trim: true)

    assert Day22.solve(
      tl(String.split(p1, "\n", trim: true)) |> Enum.map(&String.to_integer/1),
      tl(String.split(p2, "\n", trim: true)) |> Enum.map(&String.to_integer/1)
    ) == 306
  end

  test "sample part2" do
    {:ok, content} = File.read("test/resources/day22_sample.txt")
    [p1, p2] = String.split(content, "\n\n", trim: true)

    assert Day22.solve2(
      tl(String.split(p1, "\n", trim: true)) |> Enum.map(&String.to_integer/1),
      tl(String.split(p2, "\n", trim: true)) |> Enum.map(&String.to_integer/1)
    ) == 291
  end

  test "puzzle" do
    {:ok, content} = File.read("test/resources/day22.txt")
    [p1, p2] = String.split(content, "\n\n", trim: true)

    assert Day22.solve(
      tl(String.split(p1, "\n", trim: true)) |> Enum.map(&String.to_integer/1),
      tl(String.split(p2, "\n", trim: true)) |> Enum.map(&String.to_integer/1)
    ) == 32824
  end

  test "puzzle part2" do
    {:ok, content} = File.read("test/resources/day22.txt")
    [p1, p2] = String.split(content, "\n\n", trim: true)

    assert Day22.solve2(
      tl(String.split(p1, "\n", trim: true)) |> Enum.map(&String.to_integer/1),
      tl(String.split(p2, "\n", trim: true)) |> Enum.map(&String.to_integer/1)
    ) == 36515
  end
end
