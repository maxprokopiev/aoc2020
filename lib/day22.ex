defmodule Day22 do
  def solve(p1, p2) do
    cards = play([p1, p2])
    score(cards)
  end

  def solve2(p1, p2) do
    [_, cards] = rec_play([p1, p2], [])
    score(cards)
  end

  def rec_play([p1, p2], rounds) do
    cond do
      p1 == [] ->
        [:p2, p2]
      p2 == [] ->
        [:p1, p1]
      Enum.member?(rounds, [p1, p2]) ->
        [:p1, p1]
      true ->
        [c1 | r1] = p1
        [c2 | r2] = p2

        if (length(r1) >= c1) && (length(r2) >= c2) do
          case hd(rec_play([Enum.take(r1, c1), Enum.take(r2, c2)], [])) do
            :p1 ->
              rec_play([r1 ++ [c1, c2], r2], rounds ++ [[p1, p2]])
            :p2 ->
              rec_play([r1, r2 ++ [c2, c1]], rounds ++ [[p1, p2]])
          end
        else
          rec_play(round(p1, p2), rounds ++ [[p1, p2]])
        end
    end
  end

  def score(cards) do
    Enum.reduce Enum.zip(cards, length(cards)..1), 0, fn {x, y}, acc ->
      acc + x * y
    end
  end

  def play([p1, p2]) do
    cond do
      p1 == [] -> p2
      p2 == [] -> p1
      true     -> play(round(p1, p2))
    end
  end

  def round([c1 | r1], [c2 | r2]) do
    if c1 > c2 do
      [r1 ++ [c1, c2], r2]
    else
      [r1, r2 ++ [c2, c1]]
    end
  end
end
