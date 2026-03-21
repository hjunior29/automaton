defmodule AutomatonWeb.HistoryLive do
  use AutomatonWeb, :live_view

  import AutomatonWeb.Translations

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <AutomatonWeb.Layouts.app flash={@flash} locale={@locale} show_footer>
      <%!-- Page Header --%>
      <section class="py-20 bg-base-200">
        <div class="container mx-auto px-6 text-center">
          <div class="max-w-3xl mx-auto">
            <div class="badge badge-primary badge-outline gap-2 mb-6 px-4 py-3">
              <.icon name="hero-clock" class="size-4" />
              <span class="text-sm font-medium">1940 &mdash; {t(@locale, :present)}</span>
            </div>
            <h1 class="text-4xl sm:text-5xl lg:text-6xl font-extrabold tracking-tight mb-6">
              <span class="bg-gradient-to-r from-primary via-secondary to-accent bg-clip-text text-transparent">
                {t(@locale, :history_title)}
              </span>
            </h1>
            <p class="text-lg sm:text-xl text-base-content/70 leading-relaxed">
              {t(@locale, :history_subtitle)}
            </p>
          </div>
        </div>
      </section>

      <%!-- Timeline --%>
      <section class="py-16 bg-base-100">
        <div class="container mx-auto px-6">
          <div class="max-w-5xl mx-auto relative">
            <%!-- Timeline line --%>
            <div class="hidden lg:block absolute left-1/2 top-0 bottom-0 w-px bg-gradient-to-b from-primary/50 via-secondary/50 to-accent/50" />

            <%!-- 1940s: The Origins --%>
            <.timeline_item
              side={:left}
              decade={t(@locale, :history_1940s_decade)}
              title={t(@locale, :history_1940s_title)}
              icon="hero-sparkles"
              color="primary"
            >
              <p class="text-base-content/70 leading-relaxed mb-4">
                {t(@locale, :history_1940s_text)}
              </p>
              <blockquote class="border-l-4 border-primary/30 pl-4 italic text-base-content/50 text-sm">
                {t(@locale, :history_1940s_quote)}
              </blockquote>
            </.timeline_item>

            <%!-- 1950s: Von Neumann's Universal Constructor --%>
            <.timeline_item
              side={:right}
              decade={t(@locale, :history_vn_decade)}
              title={t(@locale, :history_vn_title)}
              icon="hero-cpu-chip"
              color="secondary"
            >
              <p class="text-base-content/70 leading-relaxed">
                {t(@locale, :history_vn_text)}
              </p>
            </.timeline_item>

            <%!-- 1960s: Mathematical Foundations --%>
            <.timeline_item
              side={:left}
              decade={t(@locale, :history_1960s_decade)}
              title={t(@locale, :history_1960s_title)}
              icon="hero-academic-cap"
              color="accent"
            >
              <p class="text-base-content/70 leading-relaxed">
                {t(@locale, :history_1960s_text)}
              </p>
            </.timeline_item>

            <%!-- 1970: Game of Life --%>
            <.timeline_item
              side={:right}
              decade={t(@locale, :history_gol_decade)}
              title={t(@locale, :history_gol_title)}
              icon="hero-squares-2x2"
              color="primary"
            >
              <p class="text-base-content/70 leading-relaxed mb-6">
                {t(@locale, :history_gol_text)}
              </p>

              <div class="bg-base-100 border border-base-300 rounded-xl p-6">
                <h4 class="font-bold text-base-content mb-4 flex items-center gap-2">
                  <.icon name="hero-puzzle-piece" class="size-5 text-primary" />
                  {t(@locale, :history_gol_rules_title)}
                </h4>
                <ol class="space-y-3">
                  <li class="flex items-start gap-3">
                    <span class="badge badge-primary badge-sm mt-0.5 shrink-0">1</span>
                    <span class="text-base-content/70 text-sm">{t(@locale, :history_gol_rule_1)}</span>
                  </li>
                  <li class="flex items-start gap-3">
                    <span class="badge badge-primary badge-sm mt-0.5 shrink-0">2</span>
                    <span class="text-base-content/70 text-sm">{t(@locale, :history_gol_rule_2)}</span>
                  </li>
                  <li class="flex items-start gap-3">
                    <span class="badge badge-primary badge-sm mt-0.5 shrink-0">3</span>
                    <span class="text-base-content/70 text-sm">{t(@locale, :history_gol_rule_3)}</span>
                  </li>
                  <li class="flex items-start gap-3">
                    <span class="badge badge-primary badge-sm mt-0.5 shrink-0">4</span>
                    <span class="text-base-content/70 text-sm">{t(@locale, :history_gol_rule_4)}</span>
                  </li>
                </ol>
              </div>
            </.timeline_item>

            <%!-- 1983: Wolfram's Revolution --%>
            <.timeline_item
              side={:left}
              decade={t(@locale, :history_wolfram_decade)}
              title={t(@locale, :history_wolfram_title)}
              icon="hero-light-bulb"
              color="secondary"
            >
              <p class="text-base-content/70 leading-relaxed mb-6">
                {t(@locale, :history_wolfram_text)}
              </p>

              <div class="bg-base-100 border border-base-300 rounded-xl p-6">
                <h4 class="font-bold text-base-content mb-4 flex items-center gap-2">
                  <.icon name="hero-sparkles" class="size-5 text-secondary" />
                  {t(@locale, :history_classes_title)}
                </h4>
                <div class="space-y-3">
                  <div class="flex items-start gap-3">
                    <span class="badge badge-outline badge-sm mt-0.5 shrink-0">I</span>
                    <span class="text-base-content/70 text-sm">{t(@locale, :history_class_1)}</span>
                  </div>
                  <div class="flex items-start gap-3">
                    <span class="badge badge-outline badge-sm mt-0.5 shrink-0">II</span>
                    <span class="text-base-content/70 text-sm">{t(@locale, :history_class_2)}</span>
                  </div>
                  <div class="flex items-start gap-3">
                    <span class="badge badge-outline badge-sm mt-0.5 shrink-0">III</span>
                    <span class="text-base-content/70 text-sm">{t(@locale, :history_class_3)}</span>
                  </div>
                  <div class="flex items-start gap-3">
                    <span class="badge badge-outline badge-sm mt-0.5 shrink-0">IV</span>
                    <span class="text-base-content/70 text-sm">{t(@locale, :history_class_4)}</span>
                  </div>
                </div>
              </div>
            </.timeline_item>
          </div>
        </div>
      </section>

      <%!-- Applications Section --%>
      <section class="py-20 bg-base-200">
        <div class="container mx-auto px-6">
          <div class="max-w-5xl mx-auto">
            <div class="text-center mb-6">
              <h2 class="text-3xl sm:text-4xl font-bold text-base-content">
                {t(@locale, :history_applications_title)}
              </h2>
            </div>
            <p class="text-base-content/70 text-center max-w-3xl mx-auto leading-relaxed mb-12">
              {t(@locale, :history_applications_text)}
            </p>

            <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-6">
              <%!-- Biology --%>
              <div class="card bg-base-100 border border-base-300 shadow-lg hover:shadow-xl hover:border-primary/30 transition-all duration-300">
                <div class="card-body p-6 text-center">
                  <div class="bg-primary/10 p-4 rounded-2xl w-fit mx-auto mb-4">
                    <.icon name="hero-beaker" class="size-8 text-primary" />
                  </div>
                  <h3 class="font-bold text-lg text-base-content mb-2">
                    {t(@locale, :history_app_biology)}
                  </h3>
                  <p class="text-base-content/60 text-sm leading-relaxed">
                    {t(@locale, :history_app_biology_desc)}
                  </p>
                </div>
              </div>

              <%!-- Physics --%>
              <div class="card bg-base-100 border border-base-300 shadow-lg hover:shadow-xl hover:border-secondary/30 transition-all duration-300">
                <div class="card-body p-6 text-center">
                  <div class="bg-secondary/10 p-4 rounded-2xl w-fit mx-auto mb-4">
                    <.icon name="hero-sparkles" class="size-8 text-secondary" />
                  </div>
                  <h3 class="font-bold text-lg text-base-content mb-2">
                    {t(@locale, :history_app_physics)}
                  </h3>
                  <p class="text-base-content/60 text-sm leading-relaxed">
                    {t(@locale, :history_app_physics_desc)}
                  </p>
                </div>
              </div>

              <%!-- Computer Science --%>
              <div class="card bg-base-100 border border-base-300 shadow-lg hover:shadow-xl hover:border-accent/30 transition-all duration-300">
                <div class="card-body p-6 text-center">
                  <div class="bg-accent/10 p-4 rounded-2xl w-fit mx-auto mb-4">
                    <.icon name="hero-cpu-chip" class="size-8 text-accent" />
                  </div>
                  <h3 class="font-bold text-lg text-base-content mb-2">
                    {t(@locale, :history_app_cs)}
                  </h3>
                  <p class="text-base-content/60 text-sm leading-relaxed">
                    {t(@locale, :history_app_cs_desc)}
                  </p>
                </div>
              </div>

              <%!-- Art & Music --%>
              <div class="card bg-base-100 border border-base-300 shadow-lg hover:shadow-xl hover:border-info/30 transition-all duration-300">
                <div class="card-body p-6 text-center">
                  <div class="bg-info/10 p-4 rounded-2xl w-fit mx-auto mb-4">
                    <.icon name="hero-musical-note" class="size-8 text-info" />
                  </div>
                  <h3 class="font-bold text-lg text-base-content mb-2">
                    {t(@locale, :history_app_art)}
                  </h3>
                  <p class="text-base-content/60 text-sm leading-relaxed">
                    {t(@locale, :history_app_art_desc)}
                  </p>
                </div>
              </div>
            </div>
          </div>
        </div>
      </section>
    </AutomatonWeb.Layouts.app>
    """
  end

  # ---------------------------------------------------------------
  # Timeline item component
  # ---------------------------------------------------------------
  attr :side, :atom, values: [:left, :right], default: :left
  attr :decade, :string, required: true
  attr :title, :string, required: true
  attr :icon, :string, required: true
  attr :color, :string, default: "primary"
  slot :inner_block, required: true

  defp timeline_item(assigns) do
    ~H"""
    <div class="relative grid grid-cols-1 lg:grid-cols-2 gap-8 mb-16 last:mb-0">
      <%!-- Timeline dot (desktop) --%>
      <div class="hidden lg:flex absolute left-1/2 top-8 -translate-x-1/2 z-10">
        <div class={[
          "w-4 h-4 rounded-full border-4 border-base-100",
          color_bg(@color)
        ]} />
      </div>

      <%!-- Left side --%>
      <div class={[
        "lg:pr-12",
        @side == :right && "lg:order-1"
      ]}>
        <%= if @side == :left do %>
          <.timeline_card decade={@decade} title={@title} icon={@icon} color={@color}>
            {render_slot(@inner_block)}
          </.timeline_card>
        <% else %>
          <div class="hidden lg:block" />
        <% end %>
      </div>

      <%!-- Right side --%>
      <div class={[
        "lg:pl-12",
        @side == :right && "lg:order-2"
      ]}>
        <%= if @side == :right do %>
          <.timeline_card decade={@decade} title={@title} icon={@icon} color={@color}>
            {render_slot(@inner_block)}
          </.timeline_card>
        <% else %>
          <div class="hidden lg:block" />
        <% end %>
      </div>
    </div>
    """
  end

  attr :decade, :string, required: true
  attr :title, :string, required: true
  attr :icon, :string, required: true
  attr :color, :string, default: "primary"
  slot :inner_block, required: true

  defp timeline_card(assigns) do
    ~H"""
    <div class="card bg-base-200 border border-base-300 shadow-lg">
      <div class="card-body p-6 sm:p-8">
        <div class="flex items-center gap-3 mb-4">
          <div class={["badge gap-1 font-mono font-bold", color_badge(@color)]}>
            {@decade}
          </div>
        </div>

        <div class="flex items-center gap-3 mb-4">
          <div class={["p-2 rounded-xl", color_icon_bg(@color)]}>
            <.icon name={@icon} class={["size-6", color_text(@color)]} />
          </div>
          <h3 class="text-xl sm:text-2xl font-bold text-base-content">
            {@title}
          </h3>
        </div>

        {render_slot(@inner_block)}
      </div>
    </div>
    """
  end

  # ---------------------------------------------------------------
  # Color helpers
  # ---------------------------------------------------------------
  defp color_bg("primary"), do: "bg-primary"
  defp color_bg("secondary"), do: "bg-secondary"
  defp color_bg("accent"), do: "bg-accent"
  defp color_bg(_), do: "bg-primary"

  defp color_badge("primary"), do: "badge-primary"
  defp color_badge("secondary"), do: "badge-secondary"
  defp color_badge("accent"), do: "badge-accent"
  defp color_badge(_), do: "badge-primary"

  defp color_icon_bg("primary"), do: "bg-primary/10"
  defp color_icon_bg("secondary"), do: "bg-secondary/10"
  defp color_icon_bg("accent"), do: "bg-accent/10"
  defp color_icon_bg(_), do: "bg-primary/10"

  defp color_text("primary"), do: "text-primary"
  defp color_text("secondary"), do: "text-secondary"
  defp color_text("accent"), do: "text-accent"
  defp color_text(_), do: "text-primary"
end
