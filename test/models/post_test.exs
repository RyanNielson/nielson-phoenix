defmodule Nielson.PostTest do
  use Nielson.ModelCase

  alias Nielson.Post

  @valid_attrs %{body_html: "some content", body_markdown: "some content", published_at: "2010-04-17 14:00:00", slug: "some content", summary: "some content", title: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Post.changeset(%Post{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Post.changeset(%Post{}, @invalid_attrs)
    refute changeset.valid?
  end
end
