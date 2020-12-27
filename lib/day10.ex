defmodule Day10 do
  def solve(input) do
    {ones, threes} = input |> Enum.sort |> prepend(0) |> append_builtin |> Enum.chunk_every(2, 1, :discard)
    |> Enum.map(fn [x, y] -> abs(x - y) end) |> count_ones_and_threes

    ones * threes
  end

  def solve2(input) do
    sorted = input |> Enum.sort |> prepend(0) |> append_builtin

    List.first(ways(sorted, 0, %{}))
  end

  def ways(list, i, mem) do
    cond do
      i == length(list) - 1 ->
        [1, mem]
      mem[i] != nil ->
        [mem[i], mem]
      true ->
        [ans, map] = Enum.reduce (i + 1)..(length(list) - 1), [0, mem], fn j, [acc, map] ->
          if Enum.at(list, j) - Enum.at(list, i) <= 3 do
            [inc, new_map] = ways(list, j, map)
            [acc + inc, new_map]
          else
            [acc, map]
          end
        end
        [ans, Map.put(map, i, ans)]
    end
  end

  def count_ones_and_threes(list) do
    Enum.reduce list, {0, 0}, fn e, {ones, threes} ->
      cond do
        e == 1 ->
          {ones + 1, threes}
        e == 3 ->
          {ones, threes + 1}
        true ->
          {ones, threes}
      end
    end
  end

  def prepend(list, e) do
    [e | list]
  end

  def append_builtin(list) do
    append(list, List.last(list) + 3)
  end

  def append(list, e) do
    list ++ [e]
  end
end
