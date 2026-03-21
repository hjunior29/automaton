defmodule Automaton.GameOfLife do
  @moduledoc "Conway's Game of Life engine with toroidal grid."

  @doc "Compute next generation. Grid is a MapSet of {row, col} tuples."
  def step(alive, rows, cols, wrap \\ true) do
    alive
    |> Enum.flat_map(fn {r, c} -> neighbors(r, c, rows, cols, wrap) end)
    |> Enum.frequencies()
    |> Enum.filter(fn {cell, count} ->
      count == 3 or (count == 2 and MapSet.member?(alive, cell))
    end)
    |> Enum.map(fn {cell, _} -> cell end)
    |> MapSet.new()
  end

  def toggle(alive, row, col) do
    cell = {row, col}

    if MapSet.member?(alive, cell),
      do: MapSet.delete(alive, cell),
      else: MapSet.put(alive, cell)
  end

  def random(rows, cols, density \\ 0.25) do
    for r <- 0..(rows - 1),
        c <- 0..(cols - 1),
        :rand.uniform() < density,
        into: MapSet.new() do
      {r, c}
    end
  end

  def preset(name, center_row, center_col) do
    offsets = presets()[name] || []

    for {dr, dc} <- offsets, into: MapSet.new() do
      {center_row + dr, center_col + dc}
    end
  end

  defp neighbors(r, c, rows, cols, true) do
    for dr <- -1..1, dc <- -1..1, {dr, dc} != {0, 0} do
      {rem(r + dr + rows, rows), rem(c + dc + cols, cols)}
    end
  end

  defp neighbors(r, c, rows, cols, false) do
    for dr <- -1..1,
        dc <- -1..1,
        {dr, dc} != {0, 0},
        nr = r + dr,
        nc = c + dc,
        nr >= 0 and nr < rows and nc >= 0 and nc < cols do
      {nr, nc}
    end
  end

  def presets do
    %{
      "glider" => [{0, 1}, {1, 2}, {2, 0}, {2, 1}, {2, 2}],
      "blinker" => [{0, 0}, {1, 0}, {2, 0}],
      "toad" => [{1, 0}, {1, 1}, {1, 2}, {2, -1}, {2, 0}, {2, 1}],
      "beacon" => [{0, 0}, {0, 1}, {1, 0}, {1, 1}, {2, 2}, {2, 3}, {3, 2}, {3, 3}],
      "r_pentomino" => [{0, 1}, {0, 2}, {1, 0}, {1, 1}, {2, 1}],
      "pulsar" => pulsar_offsets(),
      "glider_gun" => glider_gun_offsets()
    }
  end

  defp pulsar_offsets do
    base =
      for {r, c} <- [
            {0, 2}, {0, 3}, {0, 4}, {0, 8}, {0, 9}, {0, 10},
            {2, 0}, {2, 5}, {2, 7}, {2, 12},
            {3, 0}, {3, 5}, {3, 7}, {3, 12},
            {4, 0}, {4, 5}, {4, 7}, {4, 12},
            {5, 2}, {5, 3}, {5, 4}, {5, 8}, {5, 9}, {5, 10}
          ],
          sym_r <- [r, 12 - r],
          sym_c <- [c],
          uniq: true do
        {sym_r - 6, sym_c - 6}
      end

    Enum.uniq(base)
  end

  defp glider_gun_offsets do
    [
      {4, 0}, {4, 1}, {5, 0}, {5, 1},
      {4, 10}, {5, 10}, {6, 10}, {3, 11}, {7, 11}, {2, 12}, {8, 12}, {2, 13}, {8, 13},
      {5, 14}, {3, 15}, {7, 15}, {4, 16}, {5, 16}, {6, 16}, {5, 17},
      {2, 20}, {3, 20}, {4, 20}, {2, 21}, {3, 21}, {4, 21}, {1, 22}, {5, 22},
      {0, 24}, {1, 24}, {5, 24}, {6, 24},
      {2, 34}, {3, 34}, {2, 35}, {3, 35}
    ]
  end
end
