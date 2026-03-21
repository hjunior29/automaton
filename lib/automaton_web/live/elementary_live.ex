defmodule AutomatonWeb.ElementaryLive do
  use AutomatonWeb, :live_view
  import AutomatonWeb.Translations

  alias Automaton.ElementaryCA

  @default_rule 30
  @default_width 201
  @default_generations 150

  @impl true
  def mount(_params, _session, socket) do
    rule = @default_rule
    width = @default_width
    generations = @default_generations
    initial_type = "single"

    socket =
      socket
      |> assign(
        rule: rule,
        width: width,
        generations: generations,
        initial_type: initial_type,
        rows: [],
        rule_table: rule_table_with_bits(rule)
      )

    if connected?(socket) do
      {:ok, generate_and_push(socket)}
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
          <h1 class="text-3xl font-bold text-base-content">{t(@locale, :elem_title)}</h1>
          <p class="mt-1 text-base-content/60">{t(@locale, :elem_description)}</p>
        </div>

        <%!-- Main layout: canvas + controls --%>
        <div class="flex flex-col lg:flex-row gap-6">
          <%!-- Canvas area --%>
          <div class="flex-1 min-w-0">
            <div class="card bg-base-100 border border-base-300 shadow-lg">
              <div class="card-body p-3" id="eca-wrapper" phx-update="ignore">
                <canvas id="eca-canvas" phx-hook="ElementaryCAHook" class="rounded-lg"></canvas>
              </div>
            </div>
          </div>

          <%!-- Control panel sidebar --%>
          <div class="w-full lg:w-72 flex-shrink-0 flex flex-col gap-4">
            <%!-- Controls --%>
            <div class="card bg-base-100 border border-base-300 shadow-lg">
              <div class="card-body p-4">
                <h3 class="card-title text-sm font-semibold text-base-content/70 uppercase tracking-wider">
                  {t(@locale, :sim_controls)}
                </h3>

                <%!-- Rule input --%>
                <label class="form-control w-full mt-2">
                  <div class="label py-0">
                    <span class="label-text text-xs">{t(@locale, :elem_rule)} (0–255)</span>
                  </div>
                  <input
                    type="number"
                    name="rule"
                    value={@rule}
                    min="0"
                    max="255"
                    class="input input-bordered input-sm w-full"
                    phx-change="set_rule"
                    phx-debounce="300"
                  />
                </label>

                <%!-- Action buttons --%>
                <div class="grid grid-cols-2 gap-2 mt-3">
                  <button phx-click="generate" class="btn btn-primary btn-sm">
                    <.icon name="hero-play" class="size-4" />
                    {t(@locale, :elem_generate)}
                  </button>
                  <button phx-click="clear" class="btn btn-ghost btn-sm">
                    <.icon name="hero-trash" class="size-4" />
                    {t(@locale, :elem_clear)}
                  </button>
                </div>
              </div>
            </div>

            <%!-- Settings --%>
            <div class="card bg-base-100 border border-base-300 shadow-lg">
              <div class="card-body p-4">
                <h3 class="card-title text-sm font-semibold text-base-content/70 uppercase tracking-wider">
                  {t(@locale, :elem_settings)}
                </h3>

                <div class="flex gap-3 mt-2">
                  <label class="form-control flex-1">
                    <div class="label py-0">
                      <span class="label-text text-xs">{t(@locale, :elem_width)}</span>
                    </div>
                    <input
                      type="number"
                      name="width"
                      value={@width}
                      min="21"
                      max="501"
                      step="2"
                      class="input input-bordered input-sm w-full"
                      phx-change="set_width"
                      phx-debounce="300"
                    />
                  </label>
                  <label class="form-control flex-1">
                    <div class="label py-0">
                      <span class="label-text text-xs">{t(@locale, :elem_generations)}</span>
                    </div>
                    <input
                      type="number"
                      name="generations"
                      value={@generations}
                      min="10"
                      max="500"
                      class="input input-bordered input-sm w-full"
                      phx-change="set_generations"
                      phx-debounce="300"
                    />
                  </label>
                </div>

                <%!-- Initial state --%>
                <div class="mt-3">
                  <div class="label py-0">
                    <span class="label-text text-xs">{t(@locale, :elem_initial)}</span>
                  </div>
                  <div class="join w-full mt-1">
                    <button
                      phx-click="set_initial"
                      phx-value-type="single"
                      class={"btn btn-sm join-item flex-1 #{if @initial_type == "single", do: "btn-primary", else: "btn-ghost"}"}
                    >
                      {t(@locale, :elem_initial_single)}
                    </button>
                    <button
                      phx-click="set_initial"
                      phx-value-type="random"
                      class={"btn btn-sm join-item flex-1 #{if @initial_type == "random", do: "btn-primary", else: "btn-ghost"}"}
                    >
                      {t(@locale, :elem_initial_random)}
                    </button>
                  </div>
                </div>
              </div>
            </div>

            <%!-- Notable Rules --%>
            <div class="card bg-base-100 border border-base-300 shadow-lg">
              <div class="card-body p-4">
                <h3 class="card-title text-sm font-semibold text-base-content/70 uppercase tracking-wider">
                  {t(@locale, :elem_presets)}
                </h3>
                <div class="flex flex-col gap-1 mt-2">
                  <button
                    phx-click="set_rule"
                    phx-value-rule="30"
                    class={"btn btn-sm justify-start #{if @rule == 30, do: "btn-primary", else: "btn-ghost"}"}
                  >
                    {t(@locale, :elem_rule_30)}
                  </button>
                  <button
                    phx-click="set_rule"
                    phx-value-rule="90"
                    class={"btn btn-sm justify-start #{if @rule == 90, do: "btn-primary", else: "btn-ghost"}"}
                  >
                    {t(@locale, :elem_rule_90)}
                  </button>
                  <button
                    phx-click="set_rule"
                    phx-value-rule="110"
                    class={"btn btn-sm justify-start #{if @rule == 110, do: "btn-primary", else: "btn-ghost"}"}
                  >
                    {t(@locale, :elem_rule_110)}
                  </button>
                  <button
                    phx-click="set_rule"
                    phx-value-rule="184"
                    class={"btn btn-sm justify-start #{if @rule == 184, do: "btn-primary", else: "btn-ghost"}"}
                  >
                    {t(@locale, :elem_rule_184)}
                  </button>
                </div>
              </div>
            </div>

            <%!-- Rule table visualization --%>
            <div class="card bg-base-100 border border-base-300 shadow-lg">
              <div class="card-body p-4">
                <h3 class="card-title text-sm font-semibold text-base-content/70 uppercase tracking-wider">
                  {t(@locale, :elem_rule_table)} — {@rule}
                </h3>
                <div class="grid grid-cols-4 gap-2 mt-3">
                  <%= for %{pattern: pattern, left: left, center: center, right: right, output: output} <- @rule_table do %>
                    <div class="flex flex-col items-center gap-1">
                      <div class="flex gap-px">
                        <div class={"w-3.5 h-3.5 rounded-sm #{if left == 1, do: "bg-primary", else: "bg-base-300"}"} />
                        <div class={"w-3.5 h-3.5 rounded-sm #{if center == 1, do: "bg-primary", else: "bg-base-300"}"} />
                        <div class={"w-3.5 h-3.5 rounded-sm #{if right == 1, do: "bg-primary", else: "bg-base-300"}"} />
                      </div>
                      <div class={"w-3.5 h-3.5 rounded-sm border border-base-300 #{if output == 1, do: "bg-primary", else: "bg-base-300"}"} />
                      <span class="text-[10px] text-base-content/40 font-mono">{pattern}</span>
                    </div>
                  <% end %>
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
  def handle_event("set_rule", %{"rule" => rule_str}, socket) do
    rule = rule_str |> String.to_integer() |> max(0) |> min(255)

    socket =
      socket
      |> assign(rule: rule, rule_table: rule_table_with_bits(rule))
      |> generate_and_push()

    {:noreply, socket}
  end

  def handle_event("set_width", %{"width" => width_str}, socket) do
    width = width_str |> String.to_integer() |> max(21) |> min(501) |> ensure_odd()

    socket =
      socket
      |> assign(width: width)
      |> generate_and_push()

    {:noreply, socket}
  end

  def handle_event("set_generations", %{"generations" => gens_str}, socket) do
    generations = gens_str |> String.to_integer() |> max(10) |> min(500)

    socket =
      socket
      |> assign(generations: generations)
      |> generate_and_push()

    {:noreply, socket}
  end

  def handle_event("set_initial", %{"type" => type}, socket) do
    socket =
      socket
      |> assign(initial_type: type)
      |> generate_and_push()

    {:noreply, socket}
  end

  def handle_event("generate", _params, socket) do
    {:noreply, generate_and_push(socket)}
  end

  def handle_event("clear", _params, socket) do
    socket =
      socket
      |> assign(rows: [])
      |> push_event("render_ca", %{rows: [], width: socket.assigns.width})

    {:noreply, socket}
  end

  # -- Helpers --

  defp generate_and_push(socket) do
    %{rule: rule, width: width, generations: generations, initial_type: initial_type} =
      socket.assigns

    initial_row =
      case initial_type do
        "random" -> ElementaryCA.initial_random(width)
        _ -> ElementaryCA.initial_single(width)
      end

    rows = ElementaryCA.generate(initial_row, rule, width, generations)
    rows_as_lists = Enum.map(rows, &Tuple.to_list/1)

    socket
    |> assign(rows: rows)
    |> push_event("render_ca", %{rows: rows_as_lists, width: width})
  end

  defp rule_table_with_bits(rule) do
    import Bitwise

    for {pattern, output} <- ElementaryCA.rule_table(rule) do
      %{
        pattern: pattern,
        left: (pattern >>> 2) &&& 1,
        center: (pattern >>> 1) &&& 1,
        right: pattern &&& 1,
        output: output
      }
    end
  end

  defp ensure_odd(n) when rem(n, 2) == 0, do: n + 1
  defp ensure_odd(n), do: n
end
