defmodule Nielson.LayoutViewTest do
  use Nielson.ConnCase #, async: true
  alias Nielson.LayoutView
  alias Nielson.User

  setup do
    User.changeset(%User{}, %{email: "test@example.com", password: "test", password_confirmation: "test"})
    |> Repo.insert
    conn = conn()
    {:ok, conn: conn}
  end

  test "current user returns the user in the session", %{conn: conn} do
    conn = post conn, session_path(conn, :create), user: %{email: "test@example.com", password: "test"}
    assert LayoutView.current_user(conn)
  end

  test "current user returns nothing if there is no user in the session" do
    user = Repo.get_by(User, %{email: "test@example.com"})
    conn = delete conn, session_path(conn, :delete, user)
    refute LayoutView.current_user(conn)
  end
end
