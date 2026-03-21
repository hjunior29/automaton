defmodule AutomatonWeb.HomeLive do
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
      <%!-- Animated grid background --%>
      <style>
        @keyframes grid-fade {
          0%, 100% { opacity: 0.03; }
          50% { opacity: 0.08; }
        }
        @keyframes grid-pulse {
          0%, 100% { opacity: 0; }
          50% { opacity: 0.15; }
        }
        .grid-bg {
          background-image:
            linear-gradient(rgba(139, 92, 246, 0.05) 1px, transparent 1px),
            linear-gradient(90deg, rgba(139, 92, 246, 0.05) 1px, transparent 1px);
          background-size: 40px 40px;
          animation: grid-fade 8s ease-in-out infinite;
        }
        .grid-bg::before {
          content: '';
          position: absolute;
          inset: 0;
          background-image:
            linear-gradient(rgba(56, 189, 248, 0.04) 1px, transparent 1px),
            linear-gradient(90deg, rgba(56, 189, 248, 0.04) 1px, transparent 1px);
          background-size: 120px 120px;
          animation: grid-fade 12s ease-in-out infinite 2s;
        }
        .grid-dot::after {
          content: '';
          position: absolute;
          width: 4px;
          height: 4px;
          background: rgba(139, 92, 246, 0.3);
          border-radius: 50%;
          top: 20%;
          left: 30%;
          animation: grid-pulse 4s ease-in-out infinite;
          box-shadow:
            120px 80px 0 rgba(56, 189, 248, 0.2),
            240px 160px 0 rgba(139, 92, 246, 0.15),
            360px 60px 0 rgba(56, 189, 248, 0.25),
            80px 200px 0 rgba(139, 92, 246, 0.1),
            300px 240px 0 rgba(56, 189, 248, 0.2),
            500px 120px 0 rgba(139, 92, 246, 0.15),
            180px 300px 0 rgba(56, 189, 248, 0.1);
        }
      </style>

      <%!-- Hero Section --%>
      <section class="relative overflow-hidden min-h-[80vh] flex items-center">
        <div class="absolute inset-0 grid-bg grid-dot" />
        <div class="absolute inset-0 bg-gradient-to-b from-base-200/0 via-base-200/50 to-base-200" />

        <div class="relative z-10 container mx-auto px-6 py-24 text-center">
          <div class="max-w-4xl mx-auto">
            <h1 class="text-5xl sm:text-6xl lg:text-7xl font-extrabold tracking-tight mb-6">
              <span class="bg-gradient-to-r from-primary via-secondary to-accent bg-clip-text text-transparent">
                {t(@locale, :hero_title)}
              </span>
            </h1>

            <p class="text-lg sm:text-xl text-base-content/70 max-w-2xl mx-auto mb-10 leading-relaxed">
              {t(@locale, :hero_subtitle)}
            </p>

            <div class="flex flex-col sm:flex-row gap-4 justify-center">
              <.link navigate="/simulator" class="btn btn-primary btn-lg gap-2 shadow-lg shadow-primary/25">
                <.icon name="hero-play" class="size-5" />
                {t(@locale, :hero_cta_simulator)}
              </.link>
              <.link navigate="/history" class="btn btn-outline btn-lg gap-2">
                <.icon name="hero-clock" class="size-5" />
                {t(@locale, :hero_cta_history)}
              </.link>
            </div>
          </div>
        </div>
      </section>

      <%!-- What is a Cellular Automaton? --%>
      <section class="py-20 bg-base-100">
        <div class="container mx-auto px-6">
          <div class="max-w-4xl mx-auto">
            <div class="card bg-base-200 border border-base-300 shadow-xl">
              <div class="card-body p-8 sm:p-12">
                <div class="flex items-center gap-3 mb-4">
                  <div class="bg-primary/10 p-3 rounded-xl">
                    <.icon name="hero-light-bulb" class="size-7 text-primary" />
                  </div>
                  <h2 class="card-title text-2xl sm:text-3xl font-bold text-base-content">
                    {t(@locale, :home_what_title)}
                  </h2>
                </div>
                <p class="text-base-content/70 text-lg leading-relaxed">
                  {t(@locale, :home_what_text)}
                </p>
              </div>
            </div>
          </div>
        </div>
      </section>

      <%!-- Feature Cards --%>
      <section class="py-20 bg-base-200">
        <div class="container mx-auto px-6">
          <div class="grid grid-cols-1 md:grid-cols-2 gap-6 max-w-4xl mx-auto">
            <%!-- History Card --%>
            <.link navigate="/history" class="group">
              <div class="card bg-base-100 border border-base-300 shadow-lg h-full transition-all duration-300 hover:shadow-xl hover:border-primary/30 hover:-translate-y-1">
                <div class="card-body p-8">
                  <div class="bg-primary/10 p-3 rounded-xl w-fit mb-4 group-hover:bg-primary/20 transition-colors">
                    <.icon name="hero-academic-cap" class="size-7 text-primary" />
                  </div>
                  <h3 class="card-title text-xl font-bold text-base-content mb-2">
                    {t(@locale, :home_feature_1_title)}
                  </h3>
                  <p class="text-base-content/60 leading-relaxed">
                    {t(@locale, :home_feature_1_desc)}
                  </p>
                  <div class="card-actions justify-end mt-4">
                    <span class="text-primary text-sm font-medium flex items-center gap-1 group-hover:gap-2 transition-all">
                      <.icon name="hero-arrow-right" class="size-4" />
                    </span>
                  </div>
                </div>
              </div>
            </.link>

            <%!-- Game of Life Card --%>
            <.link navigate="/simulator" class="group">
              <div class="card bg-base-100 border border-base-300 shadow-lg h-full transition-all duration-300 hover:shadow-xl hover:border-secondary/30 hover:-translate-y-1">
                <div class="card-body p-8">
                  <div class="bg-secondary/10 p-3 rounded-xl w-fit mb-4 group-hover:bg-secondary/20 transition-colors">
                    <.icon name="hero-squares-2x2" class="size-7 text-secondary" />
                  </div>
                  <h3 class="card-title text-xl font-bold text-base-content mb-2">
                    {t(@locale, :home_feature_2_title)}
                  </h3>
                  <p class="text-base-content/60 leading-relaxed">
                    {t(@locale, :home_feature_2_desc)}
                  </p>
                  <div class="card-actions justify-end mt-4">
                    <span class="text-secondary text-sm font-medium flex items-center gap-1 group-hover:gap-2 transition-all">
                      <.icon name="hero-arrow-right" class="size-4" />
                    </span>
                  </div>
                </div>
              </div>
            </.link>

          </div>
        </div>
      </section>

      <%!-- Key Concepts --%>
      <section class="py-20 bg-base-100">
        <div class="container mx-auto px-6">
          <div class="max-w-6xl mx-auto">
            <div class="text-center mb-12">
              <h2 class="text-3xl sm:text-4xl font-bold text-base-content">
                {t(@locale, :home_concepts_title)}
              </h2>
            </div>

            <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-6">
              <%!-- Cell --%>
              <div class="card bg-base-200 border border-base-300">
                <div class="card-body p-6 text-center">
                  <div class="bg-primary/10 p-4 rounded-2xl w-fit mx-auto mb-4">
                    <.icon name="hero-cube-transparent" class="size-8 text-primary" />
                  </div>
                  <h3 class="font-bold text-lg text-base-content mb-2">
                    {t(@locale, :home_concept_cell)}
                  </h3>
                  <p class="text-base-content/60 text-sm leading-relaxed">
                    {t(@locale, :home_concept_cell_desc)}
                  </p>
                </div>
              </div>

              <%!-- Neighborhood --%>
              <div class="card bg-base-200 border border-base-300">
                <div class="card-body p-6 text-center">
                  <div class="bg-secondary/10 p-4 rounded-2xl w-fit mx-auto mb-4">
                    <.icon name="hero-squares-2x2" class="size-8 text-secondary" />
                  </div>
                  <h3 class="font-bold text-lg text-base-content mb-2">
                    {t(@locale, :home_concept_neighborhood)}
                  </h3>
                  <p class="text-base-content/60 text-sm leading-relaxed">
                    {t(@locale, :home_concept_neighborhood_desc)}
                  </p>
                </div>
              </div>

              <%!-- Rules --%>
              <div class="card bg-base-200 border border-base-300">
                <div class="card-body p-6 text-center">
                  <div class="bg-accent/10 p-4 rounded-2xl w-fit mx-auto mb-4">
                    <.icon name="hero-puzzle-piece" class="size-8 text-accent" />
                  </div>
                  <h3 class="font-bold text-lg text-base-content mb-2">
                    {t(@locale, :home_concept_rules)}
                  </h3>
                  <p class="text-base-content/60 text-sm leading-relaxed">
                    {t(@locale, :home_concept_rules_desc)}
                  </p>
                </div>
              </div>

              <%!-- Generation --%>
              <div class="card bg-base-200 border border-base-300">
                <div class="card-body p-6 text-center">
                  <div class="bg-info/10 p-4 rounded-2xl w-fit mx-auto mb-4">
                    <.icon name="hero-arrow-path" class="size-8 text-info" />
                  </div>
                  <h3 class="font-bold text-lg text-base-content mb-2">
                    {t(@locale, :home_concept_generation)}
                  </h3>
                  <p class="text-base-content/60 text-sm leading-relaxed">
                    {t(@locale, :home_concept_generation_desc)}
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
end
