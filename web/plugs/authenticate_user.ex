defmodule Nielson.Plugs.AuthenticateUser do
  import Plug.Conn
  import Phoenix.Controller, only: [put_flash: 3, redirect: 2]

  def init(opts), do: opts

  def call(conn, _opts) do
    case conn.private[:current_user] do
      nil -> unauthorized_redirect(conn)
      _   -> conn
    end
  end

  defp unauthorized_redirect(conn) do
    conn
    |> put_flash(:error, "You must be logged in.")
    |> redirect(to: "/")
    |> halt
  end
end
