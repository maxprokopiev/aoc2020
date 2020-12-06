defmodule Day1 do
  def solve(expense_report) do
    report_with_index = Enum.with_index(expense_report)

    Enum.reduce report_with_index, 1, fn {entry, i}, acc ->
      cond do
        acc == 1 ->
          other_entry = Enum.find report_with_index, fn {y, j} ->
            (i != j) && (entry + y == 2020)
          end

          if other_entry != nil do
            acc * entry * elem(other_entry, 0)
          else
            acc
          end
        true ->
          acc
      end
    end
  end

  def solve2(expense_report) do
    report_with_index = Enum.with_index(expense_report)

    Enum.reduce report_with_index, 1, fn {x, i}, acc ->
      cond do
        acc == 1 ->
          Enum.reduce report_with_index, 1, fn {y, j}, acc ->
            result = Enum.reduce report_with_index, 1, fn {z, k}, acc ->
              if (i != j) && (i != k) && (j != k) && ((x + y + z) == 2020) do
                x * y * z
              else
                acc
              end
            end

            if result != 1 do
              result
            else
              acc
            end
          end
        true ->
          acc
      end
    end
  end
end
