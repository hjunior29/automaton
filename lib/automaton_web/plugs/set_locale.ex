defmodule AutomatonWeb.Plugs.SetLocale do
  @behaviour Plug
  import Plug.Conn

  @impl true
  def init(opts), do: opts

  @impl true
  def call(conn, _opts) do
    locale = get_session(conn, :locale) || "en"
    Gettext.put_locale(AutomatonWeb.Gettext, locale)
    assign(conn, :locale, locale)
  end
end
