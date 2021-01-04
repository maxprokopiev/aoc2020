defmodule Day25 do
  @magic_number 20201227

  def solve(card_public_key, door_public_key) do
    card_loop_size = get_loop_size(card_public_key)
    door_loop_size = get_loop_size(door_public_key)

    get_enc_key(door_public_key, card_loop_size)
  end

  def get_enc_key(subject_number, loop_size, round \\ 1, value \\ 1) do
    value = rem(value * subject_number, @magic_number)
    if round == loop_size, do: value, else: get_enc_key(subject_number, loop_size, round + 1, value)
  end

  def get_loop_size(key, round \\ 1, value \\ 1) do
    value = rem(value * 7, @magic_number)
    if value == key, do: round, else: get_loop_size(key, round + 1, value)
  end
end
