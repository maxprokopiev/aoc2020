defmodule Day23 do
  def solve(s) do
    cups = String.graphemes(s) |> Enum.map(&String.to_integer/1)
    collect_labels(play(cups, hd(cups), 100, 1)) |> Enum.join
  end

  def solve2(s) do
    input = String.graphemes(s) |> Enum.map(&String.to_integer/1)
    cups = input ++ Enum.to_list((Enum.max(input) + 1)..1000000)
    new_cups = play(cups, hd(cups), 10000000, 1)
    Enum.at(new_cups, index_of(new_cups, 1) + 1)
  end

  def collect_labels(cups) do
    one_at = index_of(cups, 1)
    Enum.slice(cups, (one_at + 1)..(length(cups) - 1)) ++ Enum.slice(cups, 0..(one_at - 1))
  end

  def play(cups, current_cup, rounds, round) do
    if round > rounds do
      cups
    else
      {new_cups, new_current_cup} = move(cups, current_cup)
      play(new_cups, new_current_cup, rounds, round + 1)
    end
  end

  def move(cups, current_cup) do
    {pickup, new_cups} = pick_cups(cups, current_cup)
    destination_cup = select_destination_cup(new_cups, pickup, current_cup - 1)
    cups2 = place_cups(new_cups, pickup, destination_cup)
    {cups2, select_new_current_cup(cups2, current_cup)}
  end

  def select_new_current_cup(cups, current_cup) do
    Enum.at(cups, normalize_index(cups, index_of(cups, current_cup) + 1))
  end

  def place_cups(cups, pickup, destination_cup) do
    List.insert_at(cups, index_of(cups, destination_cup) + 1, pickup) |> List.flatten
  end

  def pick_cups(cups, current_cup) do
    from = normalize_index(cups, index_of(cups, current_cup) + 1)
    to = normalize_index(cups, index_of(cups, current_cup) + 3)

    pickup = if from > to do
      Enum.slice(cups, from..(length(cups) - 1)) ++ Enum.slice(cups, 0..to)
    else
      Enum.slice(cups, from..to)
    end

    {pickup, remove_pickup(cups, pickup)}
  end

  def normalize_index(cups, index) do
    Integer.mod(index, length(cups))
  end

  def index_of(cups, label) do
    Enum.find_index(cups, fn e -> e == label end)
  end

  def remove_pickup(cups, pickup) do
    Enum.reduce pickup, cups, fn p, new_cups ->
      List.delete(new_cups, p)
    end
  end

  def select_destination_cup(cups, pickup, destination) do
    cond do
      destination < Enum.min(cups) ->
        Enum.max(cups)
      destination in pickup ->
        select_destination_cup(cups, pickup, destination - 1)
      true ->
        destination
    end
  end
end
