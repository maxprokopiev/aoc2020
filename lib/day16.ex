defmodule Day16 do
  def solve(ranges, tickets) do
    fields = parse_ranges(ranges)

    parse_tickets(tickets)
    |> List.flatten
    |> Enum.filter(fn n -> Enum.all?(fields, fn {_, %{r1: r1, r2: r2}} -> !(n in r1) && !(n in r2) end) end)
    |> Enum.sum
  end

  def solve2(ranges, ticket, tickets) do
    fields = parse_ranges(ranges)
    valid_tickets = parse_tickets(tickets)
                    |> Enum.reject(fn t -> Enum.any?(t, fn n -> Enum.all?(fields, fn {_, %{r1: r1, r2: r2}} -> !(n in r1) && !(n in r2) end) end) end)

    ordered_names = ["departure location", "departure station", "departure platform", "departure track", "departure date", "departure time", "arrival location", "arrival station", "arrival platform", "arrival track", "class", "duration", "price", "route", "row", "seat", "train", "type", "wagon", "zone"]
    positions = find_valid_positions(valid_tickets, fields, ordered_names)
    {position, _} = reduce_positions(positions)
    parsed_ticket = parse_ticket(ticket)
    Enum.reduce 0..5, 1, fn i, acc ->
      {_, j} = Enum.at(position, i)
      acc * Enum.at(parsed_ticket, j)
    end
  end

  def reduce_positions(positions) do
    Enum.reduce_while Stream.cycle([0]), {%{}, %{}}, fn _, {map, used} ->
      {m, u} = Enum.reduce 0..19, {map, used}, fn i, {new_map, new_used} ->
        valid_j = for j <- 0..19, positions[{i,j}] && !new_used[j], into: [], do: j
        if length(valid_j) == 1 do
          {Map.put(new_map, i, hd(valid_j)), Map.put(new_used, hd(valid_j), true)}
        else
          {new_map, new_used}
        end
      end
      if length(Map.keys(m)) == 20 do
        {:halt, {m, u}}
      else
        {:cont, {m, u}}
      end
    end
  end

  def find_valid_positions(tickets, fields, names) do
    for i <- 0..19, j <- 0..19, into: %{} do
      field_name = Enum.at(names, i)

      %{r1: r1, r2: r2} = fields[field_name]

      valid_pos = Enum.all? tickets, fn t ->
        n = Enum.at(t, j)
        (n in r1) || (n in r2)
      end

      {{i, j}, valid_pos}
    end
  end

  def parse_ranges(ranges) do
    Enum.reduce String.split(ranges, "\n", trim: true), %{}, fn range, fields ->
      case Regex.run(~r/^(.+): (\d+)-(\d+) or (\d+)-(\d+)/, range) do
        [_, field, r1, r2, r3, r4] ->
          Map.put(fields, field, %{r1: to_i(r1)..to_i(r2), r2: to_i(r3)..to_i(r4)})
      end
    end
  end

  def parse_tickets(tickets) do
    [_ | ts] = String.split(tickets, "\n", trim: true)

    Enum.map ts, fn ticket ->
      String.split(ticket, ",", trim: true) |> Enum.map(&to_i/1)
    end
  end

  def parse_ticket(ticket) do
    [_, t] = String.split(ticket, "\n", trim: true)
    String.split(t, ",", trim: true) |> Enum.map(&to_i/1)
  end

  def to_i(v), do: String.to_integer(v)
end
