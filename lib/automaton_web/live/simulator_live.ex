defmodule AutomatonWeb.SimulatorLive do
  use AutomatonWeb, :live_view
  import AutomatonWeb.Translations

  alias Automaton.GameOfLife

  @default_rows 50
  @default_cols 65
  @default_speed 50

  @presets [
    {"glider", "Glider"},
    {"blinker", "Blinker"},
    {"toad", "Toad"},
    {"beacon", "Beacon"},
    {"r_pentomino", "R-Pentomino"},
    {"pulsar", "Pulsar"},
    {"glider_gun", "Gosper Glider Gun"}
  ]

  @impl true
  def mount(_params, _session, socket) do
    grid = MapSet.new()

    socket =
      socket
      |> assign(
        grid: grid,
        rows: @default_rows,
        cols: @default_cols,
        running: false,
        speed: @default_speed,
        generation: 0,
        timer_ref: nil,
        presets: @presets,
        selected_preset: nil,
        wrap: true,
        history: []
      )

    if connected?(socket) do
      {:ok, push_event(socket, "update_grid", %{cells: cells_list(grid)})}
    else
      {:ok, socket}
    end
  end

  @impl true
  def render(assigns) do
    ~H"""
    <AutomatonWeb.Layouts.app flash={@flash} locale={@locale}>
      <div class="py-6 px-4 max-w-7xl mx-auto">
        <%!-- Header --%>
        <div class="mb-6">
          <h1 class="text-3xl font-bold text-base-content">{t(@locale, :sim_title)}</h1>
          <p class="mt-1 text-base-content/60">{t(@locale, :sim_description)}</p>
        </div>

        <%!-- Main layout: canvas + controls --%>
        <div class="flex flex-col lg:flex-row gap-6">
          <%!-- Canvas area --%>
          <div class="flex-1 min-w-0">
            <div class="card bg-base-100 border border-base-300 shadow-lg">
              <div class="card-body p-3" id="gol-wrapper" phx-update="ignore">
                <canvas
                  id="gol-canvas"
                  phx-hook="GameOfLifeHook"
                  data-rows={@rows}
                  data-cols={@cols}
                  class="cursor-crosshair rounded-lg"
                ></canvas>
              </div>
            </div>
          </div>

          <%!-- Control panel sidebar --%>
          <div class="w-full lg:w-72 flex-shrink-0 flex flex-col gap-4">
            <%!-- Playback controls --%>
            <div class="card bg-base-100 border border-base-300 shadow-lg">
              <div class="card-body p-4">
                <h3 class="card-title text-sm font-semibold text-base-content/70 uppercase tracking-wider">
                  {t(@locale, :sim_controls)}
                </h3>

                <div class="grid grid-cols-2 gap-2 mt-2">
                  <%= if @running do %>
                    <button phx-click="pause" class="btn btn-warning btn-sm">
                      <.icon name="hero-pause" class="size-5" />
                      {t(@locale, :sim_pause)}
                    </button>
                  <% else %>
                    <button phx-click="play" class="btn btn-primary btn-sm">
                      <.icon name="hero-play" class="size-5" />
                      {t(@locale, :sim_play)}
                    </button>
                  <% end %>
                  <button phx-click="step" class="btn btn-ghost btn-sm" disabled={@running}>
                    <.icon name="hero-forward" class="size-5" />
                    {t(@locale, :sim_step)}
                  </button>
                  <button phx-click="clear" class="btn btn-ghost btn-sm">
                    <.icon name="hero-trash" class="size-4" />
                    {t(@locale, :sim_clear)}
                  </button>
                  <button phx-click="random" class="btn btn-ghost btn-sm">
                    <.icon name="hero-sparkles" class="size-4" />
                    {t(@locale, :sim_random)}
                  </button>
                </div>
              </div>
            </div>

            <%!-- Speed control --%>
            <div class="card bg-base-100 border border-base-300 shadow-lg">
              <div class="card-body p-4">
                <h3 class="card-title text-sm font-semibold text-base-content/70 uppercase tracking-wider">
                  {t(@locale, :sim_speed)}
                </h3>
                <form phx-change="set_speed">
                  <input
                    type="range"
                    min="1"
                    max="100"
                    value={@speed}
                    class="range range-primary range-sm mt-2"
                    name="speed"
                  />
                </form>
                <div class="flex justify-between text-xs text-base-content/50 mt-1">
                  <span>{t(@locale, :sim_speed_slow)}</span>
                  <span>{t(@locale, :sim_speed_fast)}</span>
                </div>
              </div>
            </div>

            <%!-- Boundary mode --%>
            <div class="card bg-base-100 border border-base-300 shadow-lg">
              <div class="card-body p-4">
                <h3 class="card-title text-sm font-semibold text-base-content/70 uppercase tracking-wider">
                  {t(@locale, :sim_boundary)}
                </h3>
                <label class="flex items-center gap-3 mt-2 cursor-pointer">
                  <input
                    type="checkbox"
                    class="toggle toggle-primary toggle-sm"
                    checked={@wrap}
                    phx-click="toggle_wrap"
                  />
                  <span class="text-sm">
                    {if @wrap, do: t(@locale, :sim_wrap_toroidal), else: t(@locale, :sim_wrap_bounded)}
                  </span>
                </label>
              </div>
            </div>

            <%!-- Presets --%>
            <div class="card bg-base-100 border border-base-300 shadow-lg">
              <div class="card-body p-4">
                <h3 class="card-title text-sm font-semibold text-base-content/70 uppercase tracking-wider">
                  {t(@locale, :sim_preset)}
                </h3>
                <form phx-change="load_preset">
                  <select
                    class="select select-bordered select-sm w-full mt-2"
                    name="preset"
                    disabled={@running}
                  >
                    <option value="">{t(@locale, :sim_preset_select)}</option>
                    <%= for {id, label} <- @presets do %>
                      <option value={id} selected={id == @selected_preset}>{label}</option>
                    <% end %>
                  </select>
                </form>
              </div>
            </div>

            <%!-- Stats chart --%>
            <div class="card bg-base-100 border border-base-300 shadow-lg flex-1 min-h-[180px]">
              <div class="card-body p-4 flex flex-col">
                <h3 class="card-title text-sm font-semibold text-base-content/70 uppercase tracking-wider">
                  {t(@locale, :sim_stats)}
                </h3>
                <div class="flex-1 mt-2" id="chart-wrapper" phx-update="ignore">
                  <canvas
                    id="population-chart"
                    phx-hook="PopulationChartHook"
                    class="w-full h-full"
                  ></canvas>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </AutomatonWeb.Layouts.app>
    """
  end

  # -- Events --

  @impl true
  def handle_event("toggle_cell", %{"row" => row, "col" => col}, socket) do
    grid = GameOfLife.toggle(socket.assigns.grid, row, col)
    {:noreply, assign(socket, grid: grid)}
  end

  def handle_event("play", _params, socket) do
    timer_ref = schedule_tick(socket.assigns.speed)

    {:noreply, assign(socket, running: true, timer_ref: timer_ref)}
  end

  def handle_event("pause", _params, socket) do
    cancel_timer(socket.assigns.timer_ref)

    {:noreply, assign(socket, running: false, timer_ref: nil)}
  end

  def handle_event("step", _params, socket) do
    socket = advance(socket)
    {:noreply, socket}
  end

  def handle_event("clear", _params, socket) do
    cancel_timer(socket.assigns.timer_ref)
    grid = MapSet.new()

    socket =
      socket
      |> assign(
        grid: grid,
        running: false,
        generation: 0,
        timer_ref: nil,
        selected_preset: nil,
        history: []
      )
      |> push_event("update_grid", %{cells: cells_list(grid)})
      |> push_event("clear_chart", %{})

    {:noreply, socket}
  end

  def handle_event("random", _params, socket) do
    grid = GameOfLife.random(socket.assigns.rows, socket.assigns.cols)

    socket =
      socket
      |> assign(grid: grid, generation: 0, selected_preset: nil, history: [])
      |> push_event("update_grid", %{cells: cells_list(grid)})
      |> push_event("clear_chart", %{})

    {:noreply, socket}
  end

  def handle_event("set_speed", params, socket) do
    speed_str = params["speed"] || params["value"] || "#{socket.assigns.speed}"

    case Integer.parse(speed_str) do
      {speed, _} ->
        speed = speed |> max(1) |> min(100)
        cancel_timer(socket.assigns.timer_ref)

        timer_ref =
          if socket.assigns.running,
            do: schedule_tick(speed),
            else: nil

        {:noreply, assign(socket, speed: speed, timer_ref: timer_ref)}

      :error ->
        {:noreply, socket}
    end
  end

  def handle_event("load_preset", %{"preset" => ""}, socket) do
    {:noreply, socket}
  end

  def handle_event("load_preset", %{"preset" => name}, socket) do
    center_row = div(socket.assigns.rows, 2)
    center_col = div(socket.assigns.cols, 2)
    grid = GameOfLife.preset(name, center_row, center_col)

    socket =
      socket
      |> assign(grid: grid, generation: 0, selected_preset: name, history: [])
      |> push_event("update_grid", %{cells: cells_list(grid)})
      |> push_event("clear_chart", %{})

    {:noreply, socket}
  end

  def handle_event("toggle_wrap", _params, socket) do
    {:noreply, assign(socket, wrap: !socket.assigns.wrap)}
  end

  # -- Timer --

  @impl true
  def handle_info(:tick, %{assigns: %{running: true}} = socket) do
    socket = advance(socket)
    timer_ref = schedule_tick(socket.assigns.speed)
    {:noreply, assign(socket, timer_ref: timer_ref)}
  end

  def handle_info(:tick, socket) do
    {:noreply, socket}
  end

  # -- Helpers --

  defp advance(socket) do
    %{grid: grid, rows: rows, cols: cols, generation: gen, wrap: wrap, history: history} =
      socket.assigns

    new_grid = GameOfLife.step(grid, rows, cols, wrap)
    new_gen = gen + 1
    population = MapSet.size(new_grid)
    history = Enum.take(history ++ [{new_gen, population}], -200)

    socket
    |> assign(grid: new_grid, generation: new_gen, history: history)
    |> push_event("update_grid", %{cells: cells_list(new_grid)})
    |> push_event("update_chart", %{generation: new_gen, population: population})
  end

  defp schedule_tick(speed) do
    Process.send_after(self(), :tick, speed_to_interval(speed))
  end

  defp cancel_timer(nil), do: :ok

  defp cancel_timer(ref) do
    Process.cancel_timer(ref)
  end

  defp speed_to_interval(speed) do
    # speed 1..100 → interval ~1000ms..~20ms
    # Power-8 curve: really slow only below ~20%, fast above
    t = (speed - 1) / 99
    round(20 + 980 * :math.pow(1 - t, 8))
  end

  defp cells_list(grid) do
    grid |> MapSet.to_list() |> Enum.map(fn {r, c} -> [r, c] end)
  end

end
