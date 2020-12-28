defmodule Day13 do
  def solve(buses, timestamp) do
    {mins, bus} = buses |> Enum.map(fn bus -> {(bus * (div(timestamp, bus) + 1)) - timestamp, bus} end) |> Enum.min_by(fn {mins, _} -> mins end)
    mins * bus
  end

  def solve2(buses) do
    buses |> Enum.reduce({0, 1}, &find_sequence/2) |> elem(0)
  end

  defp find_sequence({bus_id, index}, {time, step}) do
    if rem(time + index, bus_id) == 0 do
      {time, lcm(step, bus_id)}
    else
      find_sequence({bus_id, index}, {time + step, step})
    end
  end

  defp lcm(a, b), do: div(a * b, Integer.gcd(a, b))
end
