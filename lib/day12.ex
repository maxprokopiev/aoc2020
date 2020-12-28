defmodule Day12 do
  require Integer

  @dirs [:east, :south, :west, :north]

  def solve(directions) do
    {east, north, _} = Enum.reduce directions, {0, 0, 0}, fn inst, {east, north, dir} ->
      case Regex.run(~r/(\w)(\d+)/, inst) do
        [_, "N", value] ->
          v = String.to_integer(value)
          {east, north + v, dir}
        [_, "S", value] ->
          v = String.to_integer(value)
          {east, north - v, dir}
        [_, "E", value] ->
          v = String.to_integer(value)
          {east + v, north, dir}
        [_, "W", value] ->
          v = String.to_integer(value)
          {east - v, north, dir}
        [_, "L", value] ->
          v = trunc(String.to_integer(value) / 90)
          {east, north, Integer.mod(dir - v, 4)}
        [_, "R", value] ->
          v = trunc(String.to_integer(value) / 90)
          {east, north, Integer.mod(dir + v, 4)}
        [_, "F", value] ->
          v = String.to_integer(value)
          case Enum.at(@dirs, dir) do
            :east  -> {east + v, north, dir}
            :south -> {east, north - v, dir}
            :west  -> {east - v, north, dir}
            :north -> {east, north + v, dir}
          end
      end
    end

    abs(east) + abs(north)
  end

  def solve2(directions) do
    %{waypoint: _, ship: {east, north}} = Enum.reduce directions, %{waypoint: {10, 1}, ship: {0, 0}}, fn inst, %{waypoint: {we, wn}, ship: {se, sn}} ->
      case Regex.run(~r/(\w)(\d+)/, inst) do
        [_, "N", value] ->
          v = String.to_integer(value)
          %{waypoint: {we, wn + v}, ship: {se, sn}}
        [_, "S", value] ->
          v = String.to_integer(value)
          %{waypoint: {we, wn - v}, ship: {se, sn}}
        [_, "E", value] ->
          v = String.to_integer(value)
          %{waypoint: {we + v, wn}, ship: {se, sn}}
        [_, "W", value] ->
          v = String.to_integer(value)
          %{waypoint: {we - v, wn}, ship: {se, sn}}
        [_, "L", "90"] ->
          %{waypoint: {-wn, we}, ship: {se, sn}}
        [_, "L", "180"] ->
          %{waypoint: {-we, -wn}, ship: {se, sn}}
        [_, "L", "270"] ->
          %{waypoint: {wn, -we}, ship: {se, sn}}
        [_, "R", "90"] ->
          %{waypoint: {wn, -we}, ship: {se, sn}}
        [_, "R", "180"] ->
          %{waypoint: {-we, -wn}, ship: {se, sn}}
        [_, "R", "270"] ->
          %{waypoint: {-wn, we}, ship: {se, sn}}
        [_, "F", value] ->
          v = String.to_integer(value)
          %{waypoint: {we, wn}, ship: {se + (we*v), sn + (wn*v)}}
      end
    end

    abs(east) + abs(north)
  end
end
