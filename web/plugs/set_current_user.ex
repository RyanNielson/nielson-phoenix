defmodule Nielson.Plugs.SetCurrentUser do
  import Plug.Conn

  alias Nielson.Repo
  alias Nielson.User

  def init(opts), do: opts

  def call(conn, _opts) do
    case get_session(conn, :user_id) do
      nil     -> conn
      user_id -> add_user_to_conn(conn, user_id)
    end
  end

  defp add_user_to_conn(conn, user_id) do
    put_private conn, :current_user, Repo.get(User, user_id)
  end
end
