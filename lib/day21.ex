defmodule Day21 do
  def solve(input) do
    goods = parse_goods(input)

    map = Enum.reduce get_allergens(goods), %{}, fn a, acc ->
      Map.put(acc, a, MapSet.to_list(ingredients_with(goods, a)))
    end

    with_no_allergens = MapSet.to_list(get_ingredients(goods)) -- List.flatten(Map.values(find(map)))

    Enum.reduce with_no_allergens, 0, fn ing, acc ->
      acc + Enum.reduce goods, 0, fn {food, _}, acc2 ->
        acc2 + Enum.count(food, fn i -> ing == i end)
      end
    end
  end

  def solve2(input) do
    goods = parse_goods(input)

    als = Enum.sort(get_allergens(goods))
    map = Enum.reduce als, %{}, fn a, acc ->
      Map.put(acc, a, MapSet.to_list(ingredients_with(goods, a)))
    end

    map2 = find(map)
    Enum.map(als, fn a -> hd(map2[a]) end) |> Enum.join(",")
  end

  def find(map) do
    Enum.reduce_while Stream.cycle([0]), {map, []}, fn _, {acc, used} ->
      if length(used) == length(Map.keys(map)) do
        {:halt, acc}
      else
        {al, ing} = Enum.find(acc, fn {a, ins} -> (length(ins) == 1) && !(a in used) end)
        new_acc = Enum.map acc, fn {a, ins} ->
          if a == al do
            {a, ins}
          else
            {a, List.delete(ins, hd(ing))}
          end
        end
        {:cont, {new_acc |> Enum.into(%{}), used ++ [al]}}
      end
    end
  end

  def ingredients_with(goods, a) do
    Enum.reduce foods_with(goods, a), MapSet.new(), fn food, common ->
      if MapSet.size(common) == 0 do
        MapSet.new(food)
      else
        MapSet.intersection(MapSet.new(food), common)
      end
    end
  end

  def foods_with(goods, a) do
    Enum.reduce goods, [], fn {i, als}, acc ->
      if a in als do
        acc ++ [i]
      else
        acc
      end
    end
  end

  def get_ingredients(goods) do
    Enum.reduce goods, MapSet.new(), fn {i, _}, acc ->
      MapSet.union(acc, MapSet.new(i))
    end
  end

  def get_allergens(goods) do
    Enum.reduce goods, MapSet.new(), fn {_, a}, acc ->
      MapSet.union(acc, MapSet.new(a))
    end
  end

  def parse_goods(input) do
    Enum.map input, fn food ->
      case Regex.run(~r/(.+) \(contains (.+)\)/, food) do
        [_, i, a] ->
          {String.split(i, " "), String.split(a, ", ")}
      end
    end
  end
end
