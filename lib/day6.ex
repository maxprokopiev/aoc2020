defmodule Day6 do
  def solve(answers) do
    Enum.reduce answers, 0, fn group, acc ->
      count = group
                |> Enum.join
                |> String.split("", trim: true)
                |> Enum.frequencies
                |> Map.keys
                |> Enum.count

      acc + count
    end
  end

  def solve_2(answers) do
    Enum.reduce answers, 0, fn group, acc ->
      group_size = Enum.count(group)
      count = group
                |> Enum.join
                |> String.split("", trim: true)
                |> Enum.frequencies
                |> Map.values
                |> Enum.count(fn e -> e == group_size end)

      acc + count
    end
  end
end
