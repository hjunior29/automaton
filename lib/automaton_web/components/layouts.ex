defmodule AutomatonWeb.Layouts do
  use AutomatonWeb, :html

  import AutomatonWeb.Translations

  embed_templates "layouts/*"

  attr :flash, :map, required: true
  attr :locale, :string, default: "en"
  attr :current_scope, :map, default: nil
  attr :show_footer, :boolean, default: false
  slot :inner_block, required: true

  def app(assigns) do
    ~H"""
    <div class="min-h-screen flex flex-col bg-base-200">
      <header class="navbar bg-base-100/80 backdrop-blur-xl border-b border-base-300 sticky top-0 z-50">
        <div class="navbar-start">
          <.link navigate="/" class="btn btn-ghost text-lg font-bold tracking-tight gap-2">
            <img src={~p"/images/logo.png"} alt="Logo" class="size-7 rounded" />
            <span class="hidden sm:inline text-base-content/80 font-normal text-sm">
              {t(@locale, :hero_title)}
            </span>
          </.link>
        </div>

        <div class="navbar-center hidden lg:flex">
          <ul class="menu menu-horizontal gap-1 px-1">
            <li>
              <.link navigate="/" class="text-sm font-medium">
                {t(@locale, :nav_home)}
              </.link>
            </li>
            <li>
              <.link navigate="/history" class="text-sm font-medium">
                {t(@locale, :nav_history)}
              </.link>
            </li>
            <li>
              <.link navigate="/simulator" class="text-sm font-medium">
                {t(@locale, :nav_simulator)}
              </.link>
            </li>
          </ul>
        </div>

        <div class="navbar-end gap-2">
          <div class="dropdown dropdown-end">
            <button tabindex="0" class="btn btn-ghost btn-sm gap-1">
              <svg
                xmlns="http://www.w3.org/2000/svg"
                class="h-5 w-5"
                fill="none"
                viewBox="0 0 24 24"
                stroke="currentColor"
              >
                <path
                  stroke-linecap="round"
                  stroke-linejoin="round"
                  stroke-width="2"
                  d="M21 12a9 9 0 01-9 9m9-9a9 9 0 00-9-9m9 9H3m9 9a9 9 0 01-9-9m9 9c1.657 0 3-4.03 3-9s-1.343-9-3-9m0 18c-1.657 0-3-4.03-3-9s1.343-9 3-9m-9 9a9 9 0 019-9"
                />
              </svg>
              <span class="text-sm uppercase">{@locale}</span>
            </button>
            <ul
              tabindex="0"
              class="dropdown-content menu bg-base-200 rounded-box z-10 w-32 p-2 shadow-lg"
            >
              <li><a href="/locale/en" class={@locale == "en" && "active"}>English</a></li>
              <li><a href="/locale/pt" class={@locale == "pt" && "active"}>Português</a></li>
            </ul>
          </div>

          <.theme_toggle />

          <div class="dropdown dropdown-end lg:hidden">
            <div tabindex="0" role="button" class="btn btn-ghost">
              <.icon name="hero-bars-3" class="size-5" />
            </div>
            <ul
              tabindex="0"
              class="menu menu-sm dropdown-content bg-base-100 rounded-box z-10 mt-3 w-52 p-2 shadow-xl border border-base-300"
            >
              <li>
                <.link navigate="/">{t(@locale, :nav_home)}</.link>
              </li>
              <li>
                <.link navigate="/history">{t(@locale, :nav_history)}</.link>
              </li>
              <li>
                <.link navigate="/simulator">{t(@locale, :nav_simulator)}</.link>
              </li>
            </ul>
          </div>
        </div>
      </header>

      <main class="flex-1">
        {render_slot(@inner_block)}
      </main>

      <footer :if={@show_footer} class="py-8 px-4 border-t border-base-300">
        <div class="max-w-6xl mx-auto flex flex-col sm:flex-row items-center justify-between gap-4">
          <.link navigate="/" class="flex items-center gap-2">
            <img src={~p"/images/logo.png"} alt="Logo" class="w-8 h-8 rounded" />
            <span class="font-semibold text-base-content">{t(@locale, :footer_project_name)}</span>
          </.link>
          <p class="text-base-content/50 text-sm">
            {t(@locale, :footer_built_with)}
            <a href="https://github.com/hjunior29" class="text-primary hover:text-primary/80">
              hjunior29
            </a>
          </p>
        </div>
      </footer>
    </div>

    <.flash_group flash={@flash} />
    """
  end

  attr :flash, :map, required: true, doc: "the map of flash messages"
  attr :id, :string, default: "flash-group", doc: "the optional id of flash container"

  def flash_group(assigns) do
    ~H"""
    <div id={@id} aria-live="polite">
      <.flash kind={:info} flash={@flash} />
      <.flash kind={:error} flash={@flash} />

      <.flash
        id="client-error"
        kind={:error}
        title={gettext("We can't find the internet")}
        phx-disconnected={show(".phx-client-error #client-error") |> JS.remove_attribute("hidden")}
        phx-connected={hide("#client-error") |> JS.set_attribute({"hidden", ""})}
        hidden
      >
        {gettext("Attempting to reconnect")}
        <.icon name="hero-arrow-path" class="ml-1 size-3 motion-safe:animate-spin" />
      </.flash>

      <.flash
        id="server-error"
        kind={:error}
        title={gettext("Something went wrong!")}
        phx-disconnected={show(".phx-server-error #server-error") |> JS.remove_attribute("hidden")}
        phx-connected={hide("#server-error") |> JS.set_attribute({"hidden", ""})}
        hidden
      >
        {gettext("Attempting to reconnect")}
        <.icon name="hero-arrow-path" class="ml-1 size-3 motion-safe:animate-spin" />
      </.flash>
    </div>
    """
  end

  def theme_toggle(assigns) do
    ~H"""
    <div class="card relative flex flex-row items-center border-2 border-base-300 bg-base-300 rounded-full">
      <div class="absolute w-1/3 h-full rounded-full border-1 border-base-200 bg-base-100 brightness-200 left-0 [[data-theme=light]_&]:left-1/3 [[data-theme=dark]_&]:left-2/3 transition-[left]" />

      <button
        class="flex p-2 cursor-pointer w-1/3"
        phx-click={JS.dispatch("phx:set-theme")}
        data-phx-theme="system"
      >
        <.icon name="hero-computer-desktop-micro" class="size-4 opacity-75 hover:opacity-100" />
      </button>

      <button
        class="flex p-2 cursor-pointer w-1/3"
        phx-click={JS.dispatch("phx:set-theme")}
        data-phx-theme="light"
      >
        <.icon name="hero-sun-micro" class="size-4 opacity-75 hover:opacity-100" />
      </button>

      <button
        class="flex p-2 cursor-pointer w-1/3"
        phx-click={JS.dispatch("phx:set-theme")}
        data-phx-theme="dark"
      >
        <.icon name="hero-moon-micro" class="size-4 opacity-75 hover:opacity-100" />
      </button>
    </div>
    """
  end
end
