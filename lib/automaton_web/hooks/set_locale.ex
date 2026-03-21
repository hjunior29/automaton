defmodule AutomatonWeb.Hooks.SetLocale do
  @moduledoc "LiveView on_mount hook to set locale from session."
  import Phoenix.Component

  def on_mount(:default, _params, session, socket) do
    locale = Map.get(session, "locale", "en")
    Gettext.put_locale(AutomatonWeb.Gettext, locale)
    {:cont, assign(socket, :locale, locale)}
  end
end
