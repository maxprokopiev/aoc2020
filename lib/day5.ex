defmodule Day5 do
  def solve(pass) do
    {row, column} = Enum.reduce String.split(pass, "", trim: true), {0..127, 0..7}, fn inst, {row, column} ->
      row_count = if is_integer(row) do
        2
      else
        Enum.count(row)
      end
      column_count = if is_integer(column) do
        2
      else
        Enum.count(column)
      end

      case [inst, row_count, column_count] do
        ["F", 2, _] ->
          {Enum.at(row, 0), column}
        ["F", _, _] ->
          {Enum.take(row, div(row_count, 2)), column}
        ["B", 2, _] ->
          {Enum.at(row, 1), column}
        ["B", _, _] ->
          {Enum.drop(row, div(row_count, 2)), column}
        ["R", _, 2] ->
          {row, Enum.at(column, 1)}
        ["R", _, _] ->
          {row, Enum.drop(column, div(column_count, 2))}
        ["L", _, 2] ->
          {row, Enum.at(column, 0)}
        ["L", _, _] ->
          {row, Enum.take(column, div(column_count, 2))}
      end
    end

    [row, column, row * 8 + column]
  end
end
