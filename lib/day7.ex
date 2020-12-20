defmodule Day7 do
  def solve(rules) do
    graph = build_graph(rules)
    count_options(graph, "shiny gold") |> Enum.frequencies |> Map.keys |> Enum.count
  end

  def count_options(graph, bag) do
    if graph[bag][:parents] == [] do
      []
    else
      Enum.reduce graph[bag][:parents], graph[bag][:parents], fn parent, acc ->
        acc ++ count_options(graph, parent)
      end
    end
  end

  def solve_2(rules) do
    graph = build_graph(rules)
    count_bags(graph, "shiny gold") - 1
  end

  def count_bags(graph, bag) do
    if graph[bag][:children] == [] do
      1
    else
      Enum.reduce graph[bag][:children], 1, fn {name, count}, acc ->
        acc + (count * count_bags(graph, name))
      end
    end
  end

  def build_graph(rules) do
    Enum.reduce rules, %{}, fn rule, graph ->
      case Regex.run(~r/(\w+\s\w+) bags? contain (\d \w+ \w+ bags?),? ?(\d \w+ \w+ bags?)?,? ?(\d \w+ \w+ bags?)?,? ?(\d \w+ \w+ bags?)?./, rule) do
        [_, root, c1, c2, c3, c4] ->
          children = [parse_child(c1), parse_child(c2), parse_child(c3), parse_child(c4)]
          graph
            |> update_root(root, children)
            |> update_child(root, elem(parse_child(c1), 0))
            |> update_child(root, elem(parse_child(c2), 0))
            |> update_child(root, elem(parse_child(c3), 0))
            |> update_child(root, elem(parse_child(c4), 0))
        [_, root, c1, c2, c3] ->
          children = [parse_child(c1), parse_child(c2), parse_child(c3)]
          graph
            |> update_root(root, children)
            |> update_child(root, elem(parse_child(c1), 0))
            |> update_child(root, elem(parse_child(c2), 0))
            |> update_child(root, elem(parse_child(c3), 0))
        [_, root, c1, c2] ->
          children = [parse_child(c1), parse_child(c2)]
          graph
            |> update_root(root, children)
            |> update_child(root, elem(parse_child(c1), 0))
            |> update_child(root, elem(parse_child(c2), 0))
        [_, root, c1] ->
          children = [parse_child(c1)]
          graph
            |> update_root(root, children)
            |> update_child(root, elem(parse_child(c1), 0))
        nil ->
          case Regex.run(~r/(\w+\s\w+) bags contain no other bags\./, rule) do
            [_, root] ->
              graph |> update_root(root, [])
            nil ->
              nil
          end
      end
    end
  end

  def parse_child(rule) do
    case Regex.run(~r/(\d) (\w+ \w+) bags?/, rule) do
      [_, count, name] ->
        {name, String.to_integer(count)}
      nil ->
        nil
    end
  end

  def update_root(graph, root, children) do
    case Map.fetch(graph, root) do
      {:ok, data} ->
        Map.put(graph, root, %{children: children, parents: data[:parents]})
      _ ->
        Map.put(graph, root, %{children: children, parents: []})
    end
  end

  def update_child(graph, root, child) do
    case Map.fetch(graph, child) do
      {:ok, data} ->
        Map.put(graph, child, %{children: data[:children], parents: data[:parents] ++ [root]})
      _ ->
        Map.put(graph, child, %{children: [], parents: [root]})
    end
  end
end
