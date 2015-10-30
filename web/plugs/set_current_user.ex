defmodule Nielson.Plugs.SetCurrentUser do
  import Plug.Conn

  def init(opts), do: opts

  def call(conn, _opts) do
    if get_session(conn, :user_id) do
      conn = add_current_user_to_session(conn)
    end

    conn
  end

  defp add_current_user_to_session(conn) do
    user = Nielson.Repo.get(Nielson.User, get_session(conn, :user_id))

    Plug.Conn.put_private(conn, :current_user, user)
  end
end
