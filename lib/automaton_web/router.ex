defmodule AutomatonWeb.Router do
  use AutomatonWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {AutomatonWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug AutomatonWeb.Plugs.SetLocale
  end

  scope "/", AutomatonWeb do
    pipe_through :browser

    post "/set-locale/:locale", LocaleController, :update
    get "/locale/:locale", LocaleController, :update

    live_session :default, on_mount: [{AutomatonWeb.Hooks.SetLocale, :default}] do
      live "/", HomeLive
      live "/history", HistoryLive
      live "/simulator", SimulatorLive
    end
  end
end
