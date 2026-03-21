defmodule AutomatonWeb.LocaleController do
  use AutomatonWeb, :controller

  def update(conn, %{"locale" => locale}) when locale in ["en", "pt"] do
    referer =
      case get_req_header(conn, "referer") do
        [ref | _] ->
          case URI.parse(ref) do
            %URI{path: path} when is_binary(path) -> path
            _ -> "/"
          end

        _ ->
          "/"
      end

    conn
    |> put_session(:locale, locale)
    |> redirect(to: referer)
  end

  def update(conn, _params) do
    redirect(conn, to: "/")
  end
end
