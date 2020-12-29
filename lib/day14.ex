defmodule Day14 do
  def solve(input) do
    {memory, _} = Enum.reduce input, {%{}, []}, fn inst, {memory, mask} ->
      case String.split(inst) do
        ["mask", _, new_mask] ->
          {memory, new_mask |> String.graphemes}
        [mem, _, v] ->
          address = mem |> String.replace(~r/[^\d]/, "") |> String.to_integer
          value = to_binary(v)

          new_value = Enum.zip(value, mask) |> Enum.map(fn {v, m} -> if m == "X", do: v, else: String.to_integer(m) end)

          {Map.put(memory, address, new_value), mask}
      end
    end

    Map.values(memory) |> Enum.map(fn e -> Enum.join(e) |> String.to_integer(2) end) |> Enum.sum
  end

  def solve2(input) do
    {memory, _} = Enum.reduce input, {%{}, []}, fn inst, {memory, mask} ->
      case String.split(inst) do
        ["mask", _, new_mask] ->
          {memory, new_mask |> String.graphemes}
        [mem, _, v] ->
          address = mem |> String.replace(~r/[^\d]/, "") |> to_binary
          value = String.to_integer(v)

          masked_address = Enum.zip(address, mask) |> Enum.map(&apply_mask/1)
          xs = Enum.count(masked_address, fn e -> e == "X" end)
          addresses = Enum.map perms(xs), fn e ->
            new_address = Enum.reduce e, Enum.join(masked_address), fn i, s ->
              Regex.replace(~r/^([^X]*)X(.*)/, s, "\\g{1}#{i}\\g{2}")
            end
            new_address |> String.to_integer(2)
          end

          new_m = Enum.reduce addresses, memory, fn addr, m ->
            Map.put(m, addr, value)
          end
          {new_m, mask}
      end
    end

    Map.values(memory) |> Enum.sum
  end

  def apply_mask({a, m}) do
    case m do
      "0" -> a
      "1" -> "1"
      "X" -> "X"
    end
  end

  def perms(xs) do
    for i <- 0..trunc(:math.pow(2, xs) - 1), into: [] do
      to_binary(Integer.to_string(i), xs)
    end
  end

  def to_integer(v) do
    Enum.join(v) |> String.to_integer(2)
  end

  def to_binary(v, padding \\ 36) do
    String.to_integer(v)
    |> Integer.to_string(2)
    |> String.pad_leading(padding, "0")
    |> String.graphemes
    |> Enum.map(fn e -> String.to_integer(e) end)
  end
end
