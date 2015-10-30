defmodule Nielson.SharedView do
  use Nielson.Web, :view

  def current_user(conn) do
    conn.private[:current_user]
  end
end
