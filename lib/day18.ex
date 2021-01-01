defmodule Day18 do
  def solve(expr) do
    elems = String.graphemes(Regex.replace(~r/\s/, expr, ""))
    to_i(eval(elems, 0, []))
  end

  def eval(elems, pos, stack) do
    cond do
      length(elems) == pos ->
        hd(reduce_stack(stack, true))
      true ->
        elem = Enum.at(elems, pos)

        x = Enum.at(stack, 0)
        op = Enum.at(stack, 1)

        case [op, x] do
          ["+", n] ->
            if n =~ ~r/\d+/ do
              eval(elems, pos, reduce_stack(stack))
            else
              eval(elems, pos + 1, [elem | stack])
            end
          [_, ")"] -> eval(elems, pos, reduce_stack(stack))
          _ -> eval(elems, pos + 1, [elem | stack])
        end
    end
  end

  def reduce_stack(stack, clean \\ false) do
    if length(stack) == 1 do
      stack
    else
      x = Enum.at(stack, 0)
      op = Enum.at(stack, 1)
      y = Enum.at(stack, 2)

      case [x, op] do
        [")", _] ->
          reduce_stack(Enum.drop(stack, 1), clean)
        [_, "("] ->
          if clean do
            reduce_stack([x | Enum.drop(stack, 2)], clean)
          else
            [x | Enum.drop(stack, 2)]
          end
        _ ->
          value = Integer.to_string(calc(to_i(x), to_i(y), op))

          if (op == "+") && !clean do
            [value | Enum.drop(stack, 3)]
          else
            reduce_stack([value | Enum.drop(stack, 3)], clean)
          end
      end
    end
  end

  def calc(x, y, op) do
    case op do
      "*" -> x * y
      "+" -> x + y
    end
  end

  def to_i(v), do: v |> String.replace(~r/[^\d]/, "") |> String.to_integer
end
