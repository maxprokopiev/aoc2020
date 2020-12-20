defmodule Day8 do
  def solve(program) do
    eval(program, 0, 0, [])
  end

  def eval(program, pointer, acc, past_pointers) do
    if Enum.member?(past_pointers, pointer) do
      acc
    else
      instruction = Enum.at(program, pointer)
      case Regex.run(~r/(nop|acc|jmp) ([+-]\d+)/, instruction) do
        [_, "nop", _] ->
          eval(program, pointer + 1, acc, past_pointers ++ [pointer])
        [_, "acc", value] ->
          eval(program, pointer + 1, acc + String.to_integer(value), past_pointers ++ [pointer])
        [_, "jmp", value] ->
          eval(program, pointer + String.to_integer(value), acc, past_pointers ++ [pointer])
      end
    end
  end

  defp find_ops(program, op) do
    Enum.reduce Enum.with_index(program), [], fn {instruction, i}, jmps ->
      if instruction =~ op do
        jmps ++ [i]
      else
        jmps
      end
    end
  end

  defp replace_op(program, index, op, new_op) do
    Enum.map Enum.with_index(program), fn {instruction, i} ->
      if i == index do
        Regex.replace(op, instruction, new_op)
      else
        instruction
      end
    end
  end

  defp find_correct(programs) do
    Enum.reduce programs, nil, fn program, acc ->
      result = eval_2(program, 0, 0, [])
      if result != nil, do: result, else: acc
    end
  end

  def solve_2(program) do
    jmps = program
      |> find_ops(~r/jmp.*/)
      |> Enum.map(&replace_op(program, &1, ~r/jmp/, "nop"))
      |> find_correct

    nops = program
      |> find_ops(~r/nop.*/)
      |> Enum.map(&replace_op(program, &1, ~r/nop/, "jmp"))
      |> find_correct

    if jmps == nil, do: nops, else: jmps
  end

  def eval_2(program, pointer, acc, past_pointers) do
    cond do
      List.last(past_pointers) == length(program) - 1 ->
        acc
      Enum.member?(past_pointers, pointer) ->
        nil
      true ->
        instruction = Enum.at(program, pointer)
        case Regex.run(~r/(nop|acc|jmp) ([+-]\d+)/, instruction) do
          [_, "nop", _] ->
            eval_2(program, pointer + 1, acc, past_pointers ++ [pointer])
          [_, "acc", value] ->
            eval_2(program, pointer + 1, acc + String.to_integer(value), past_pointers ++ [pointer])
          [_, "jmp", value] ->
            eval_2(program, pointer + String.to_integer(value), acc, past_pointers ++ [pointer])
        end
    end
  end
end
