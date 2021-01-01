defmodule Day19 do
  def solve(rules, messages) do
    rule_map = Enum.reduce rules, %{}, fn rule, acc ->
      case Regex.run(~r/(\d+): (.+)/, rule) do
        [_, num, instr] ->
          Map.put(acc, num, instr)
      end
    end

    Enum.count messages, fn message ->
      find(message, rule_map, String.split(rule_map["0"]), 0)
    end
  end

  def find(to_check, map, messages, i) do
    rule = Enum.at(messages, i)

    cond do
      rule == nil ->
        false
      map[rule] in ["\"a\"", "\"b\""] ->
        if String.at(to_check, i) == String.at(map[rule], 1) do
          if (i == String.length(to_check) - 1) && (length(Enum.uniq(messages)) == 2) do
            true
          else
            find(to_check, map, messages, i + 1)
          end
        else
          false
        end
      map[rule] =~ ~r/\|/ ->
        [p1, p2] = String.split(map[rule], "|")

        new_messages = List.delete_at(messages, i)

        l1 = List.flatten(List.insert_at(new_messages, i, String.split(p1)))
        l2 = List.flatten(List.insert_at(new_messages, i, String.split(p2)))

        find(to_check, map, l1, i) || find(to_check, map, l2, i)
      true ->
        p = String.split(map[rule])
        new_messages = List.delete_at(messages, i)
        find(to_check, map, List.flatten(List.insert_at(new_messages, i, p)), i)
    end
  end
end
