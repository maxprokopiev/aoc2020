defmodule Day9 do
  def solve(input, preamble_length) do
    sums = Enum.map(pairs(Enum.take(input, preamble_length)), fn [x, y] -> x + y end)
    next = Enum.at(input, preamble_length)

    if Enum.member?(sums, next) do
      solve(Enum.drop(input, 1), preamble_length)
    else
      next
    end
  end

  def solve2(input, number, i \\ 0, count \\ 2) do
    chunk = Enum.slice(input, i, count)
    sum = Enum.sum(chunk)

    cond do
      sum == number ->
        Enum.max(chunk) + Enum.min(chunk)
      sum > number ->
        solve2(input, number, i + 1, 2)
      true ->
        solve2(input, number, i, count + 1)
    end
  end

  def pairs(list) do
    [x | xs] = list

    if xs == [] do
      []
    else
      result = Enum.reduce xs, [], fn e, acc ->
        acc ++ [[x, e]]
      end

      Enum.concat(result, pairs(xs))
    end
  end
end
