defmodule Day17Test do
  use ExUnit.Case
  doctest Day17

  test "finds active cubes" do
    section = [
     [".", ".", ".", ".", "."],
     [".", ".", "#", ".", "."],
     [".", ".", ".", "#", "."],
     [".", "#", "#", "#", "."],
     [".", ".", ".", ".", "."],
    ]

    map = section
            |> Day17.convert
            |> Day17.iterate
            |> Day17.iterate
            |> Day17.iterate
            |> Day17.iterate
            |> Day17.iterate
            |> Day17.iterate

    # 3 dimensions: assert Enum.count(Map.values(map), fn e -> e == true end) == 112
    assert Enum.count(Map.values(map), fn e -> e == true end) == 848
  end

  test "finds active cubes from file" do
    {:ok, content} = File.read("test/resources/day17.txt")

    section = content
                  |> String.split("\n", trim: true)
                  |> Enum.map(&String.split(&1, "", trim: true))

    map = section
            |> Day17.convert
            |> Day17.iterate
            |> Day17.iterate
            |> Day17.iterate
            |> Day17.iterate
            |> Day17.iterate
            |> Day17.iterate

    assert Enum.count(Map.values(map), fn e -> e == true end) == 2028
  end
end
