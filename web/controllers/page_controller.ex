defmodule Nielson.PageController do
  use Nielson.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
