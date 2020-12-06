defmodule Day2 do
  def solve(rules, valid?) do
    Enum.count rules, valid?
  end

  # 1-3 a: abcde
  def valid?(rule) do
    case Regex.run(~r{(\d+)\-(\d+)\s(\w):\s(\w+)}, rule) do
      [_, min, max, letter, password] ->
        min = String.to_integer(min)
        max = String.to_integer(max)

        count = Regex.scan(~r/#{letter}/, password) |> Enum.count
        count >= min && count <= max
      nil ->
        false
    end
  end

  def valid2?(rule) do
    case Regex.run(~r{(\d+)\-(\d+)\s(\w):\s(\w+)}, rule) do
      [_, pos1, pos2, letter, password] ->
        pos1 = String.to_integer(pos1)
        pos2 = String.to_integer(pos2)

        at1 = String.at(password, pos1 - 1)
        at2 = String.at(password, pos2 - 1)

        ((at1 == letter) && (at2 != letter)) || ((at1 != letter) && (at2 == letter))
      nil ->
        false
    end
  end
end
