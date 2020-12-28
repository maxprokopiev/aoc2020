defmodule Day11 do
  def solve(map) do
    seats = convert_to_seats(map)

    find_stable(seats, seats, 0, &iterate/1)
  end

  def solve2(map) do
    seats = convert_to_seats(map)

    find_stable(seats, seats, 0, &iterate2/1)
  end

  def find_stable(seats, prev_seats, cycles, iterate_f) do
    if (seats == prev_seats) && (cycles != 0) do
      Map.values(seats) |> Enum.count(fn e -> e == "#" end)
    else
      find_stable(iterate_f.(seats), seats, cycles + 1, iterate_f)
    end
  end

  def iterate(seats) do
    Enum.reduce seats, %{}, fn {{i, j}, v}, new_seats ->
      cond do
        (v == "#") && (count_adjacent(seats, i, j) >= 4) ->
          Map.put(new_seats, {i, j}, "L")
        (v == "L") && (count_adjacent(seats, i, j) == 0) ->
          Map.put(new_seats, {i, j}, "#")
        true ->
          Map.put(new_seats, {i, j}, v)
      end
    end
  end

  def count_adjacent(seats, i, j) do
    Enum.count [
      seats[{i - 1, j + 1}],
      seats[{i, j + 1}],
      seats[{i + 1, j + 1}],
      seats[{i - 1, j}],
      seats[{i + 1, j}],
      seats[{i - 1, j - 1}],
      seats[{i + 1, j - 1}],
      seats[{i, j - 1}]
    ], fn e -> e == "#" end
  end

  def convert_to_seats(map) do
    for {row, i} <- Enum.with_index(map), {cell, j} <- Enum.with_index(row), into: %{} do
      {{i, j}, cell}
    end
  end

  def iterate2(seats) do
    Enum.reduce seats, %{}, fn {{i, j}, v}, new_seats ->
      cond do
        (v == "#") && (count_adjacent2(seats, i, j) >= 5) ->
          Map.put(new_seats, {i, j}, "L")
        (v == "L") && (count_adjacent2(seats, i, j) == 0) ->
          Map.put(new_seats, {i, j}, "#")
        true ->
          Map.put(new_seats, {i, j}, v)
      end
    end
  end

  def count_adjacent2(seats, i, j) do
    Enum.count [
      check(seats, i, j, -1, 1),
      check(seats, i, j,  0, 1),
      check(seats, i, j,  1, 1),
      check(seats, i, j, -1, 0),
      check(seats, i, j,  1, 0),
      check(seats, i, j, -1, -1),
      check(seats, i, j,  0, -1),
      check(seats, i, j,  1, -1)
    ], fn e -> e == true end
  end

  def check(seats, i, j, dir_i, dir_j, step \\ 1) do
    case seats[{i + dir_i * step, j + dir_j * step}] do
      "#" -> true
      "L" -> false
      nil -> false
      "." -> check(seats, i, j, dir_i, dir_j, step + 1)
    end
  end
end
