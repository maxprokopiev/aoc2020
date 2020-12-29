defmodule Day15 do
  def solve(numbers) do
    map = for {n, i} <- Enum.take(Enum.with_index(numbers), length(numbers)), into: %{} do
      {n, %{last: i + 1, recent: i + 1}}
    end

    last = List.last(numbers)
    {_, n} = Enum.reduce (length(numbers) + 1)..30000000, {map, List.last(numbers)}, fn turn, {m, n} ->
      case m[n] do
        nil ->
          {Map.put(m, 0, %{last: m[0][:recent] || turn, recent: turn}), 0}
        %{last: x, recent: y} when x == y ->
          {Map.put(m, 0, %{last: m[0][:recent] || turn, recent: turn}), 0}
        %{last: x, recent: y} ->
          age = y - x
          {Map.put(m, age, %{last: m[age][:recent] || turn, recent: turn}), age}
      end
    end

    n
  end
end
