defmodule Automaton.ElementaryCA do
  @moduledoc "Elementary (1D) cellular automaton engine."

  import Bitwise

  @doc "Compute next row from current row using the given rule (0-255)."
  def step(row, rule, width) do
    for i <- 0..(width - 1) do
      left = elem(row, rem(i - 1 + width, width))
      center = elem(row, i)
      right = elem(row, rem(i + 1, width))
      pattern = left * 4 + center * 2 + right
      (rule >>> pattern) &&& 1
    end
    |> List.to_tuple()
  end

  @doc "Generate n generations starting from initial row."
  def generate(initial_row, rule, width, n) do
    Enum.reduce(1..(n - 1), [initial_row], fn _, [prev | _] = acc ->
      [step(prev, rule, width) | acc]
    end)
    |> Enum.reverse()
  end

  @doc "Create initial row with a single cell in the center."
  def initial_single(width) do
    List.duplicate(0, width)
    |> List.replace_at(div(width, 2), 1)
    |> List.to_tuple()
  end

  @doc "Create random initial row."
  def initial_random(width) do
    for _ <- 1..width do
      if :rand.uniform() < 0.5, do: 1, else: 0
    end
    |> List.to_tuple()
  end

  @doc "Decode a rule number into its 8 output bits for display."
  def rule_table(rule) do
    for pattern <- 7..0//-1 do
      {pattern, (rule >>> pattern) &&& 1}
    end
  end
end
