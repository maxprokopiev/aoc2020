defmodule Day23 do
  def solve(s) do
    input = String.graphemes(s) |> Enum.map(&String.to_integer/1)

    cups = :atomics.new(length(input), [])

    input
    |> Enum.chunk_every(2, 1)
    |> Enum.each(fn
      [label, next] -> :atomics.put(cups, label, next)
      [label] -> :atomics.put(cups, label, hd(input))
    end)

    play(cups, hd(input), 100, Enum.max(input))
    collect(cups, length(input))
  end

  def solve2(s) do
    input = (String.graphemes(s) |> Enum.map(&String.to_integer/1)) ++ Enum.to_list(10..1000000)

    cups = :atomics.new(length(input), [])

    input
    |> Enum.chunk_every(2, 1)
    |> Enum.each(fn
      [label, next] -> :atomics.put(cups, label, next)
      [label] -> :atomics.put(cups, label, hd(input))
    end)

    play(cups, hd(input), 10000000, Enum.max(input))
    first = :atomics.get(cups, 1)
    second = :atomics.get(cups, first)

    first * second
  end

  def collect(cups, size) do
    {_, c} = Enum.reduce 1..(size - 1), {1, []}, fn _, {i, acc} ->
      next = :atomics.get(cups, i)
      {next, acc ++ [next]}
    end
    c |> Enum.join
  end

  def play(cups, current_cup, rounds, max) do
    Enum.reduce 1..rounds, current_cup, fn _, c ->
      move(cups, c, max)
    end
  end

  def move(cups, current_cup, max) do
    pickup = [_, _, third] = pick_cups(cups, current_cup)
    destination_cup = select_destination_cup(current_cup, pickup, max)

    third_next = :atomics.get(cups, third)
    current_next = :atomics.get(cups, current_cup)
    dest_next = :atomics.get(cups, destination_cup)

    :atomics.put(cups, current_cup, third_next)
    :atomics.put(cups, third, dest_next)
    :atomics.put(cups, destination_cup, current_next)

    third_next
  end

  def pick_cups(cups, current_cup) do
    a = :atomics.get(cups, current_cup)
    b = :atomics.get(cups, a)
    c = :atomics.get(cups, b)

    [a, b, c]
  end

  def select_destination_cup(current_cup, pickup, max) do
    destination = if current_cup == 1, do: max, else: current_cup - 1

    if destination in pickup do
      select_destination_cup(destination, pickup, max)
    else
      destination
    end
  end
end
