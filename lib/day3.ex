defmodule Day3 do
  def solve(map, w, h, step_i, step_j) do
    steps = for j <- step_j..h, rem(j, step_j) == 0, do: j

    {_, result} = Enum.reduce steps, {step_i, 0}, fn j, {i, sum} ->
      point = Enum.at(map, Integer.mod(i, w) + (j * w))
      if point == "#" do
        {i + step_i, sum + 1}
      else
        {i + step_i, sum}
      end
    end

    result
  end

  def all_slopes(map, w, h) do
    Enum.reduce [{1, 1}, {3, 1}, {5, 1}, {7, 1}, {1, 2}], 1, fn {step_i, step_j}, acc ->
      acc * solve(map, w, h, step_i, step_j)
    end
  end
end
