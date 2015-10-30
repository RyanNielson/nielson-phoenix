defmodule Nielson.SessionController do
  use Nielson.Web, :controller
  alias Nielson.User
  import Comeonin.Bcrypt, only: [checkpw: 2]

  def new(conn, _params) do
    render conn, :new, changeset: User.changeset(%User{})
  end

  def create(conn, %{"user" => user_params}) do
    user = Repo.get_by(User, email: user_params["email"])
    user
    |> sign_in(user_params["password"], conn)
  end

  def delete(conn, _params) do
    conn
    |> delete_session(:user_id)
    |> put_flash(:info, "Signed out successfully!")
    |> redirect(to: root_path(conn, :index))
  end

  defp sign_in(user, _password, conn) when is_nil(user) do
    conn
    |> put_flash(:error, "Invalid email/password combination!")
    |> redirect(to: root_path(conn, :index))
  end

  defp sign_in(user, password, conn) do
    if checkpw(password, user.password_digest) do
      conn
      |> put_session(:user_id, user.id)
      |> put_flash(:info, "Sign in successful!")
      |> redirect(to: root_path(conn, :index))
    else
      conn
      |> put_session(:user_id, nil)
      |> put_flash(:error, "Invalid email/password combination!")
      |> redirect(to: root_path(conn, :index))
    end
  end
end
