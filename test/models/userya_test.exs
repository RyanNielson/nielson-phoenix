defmodule Nielson.UseryaTest do
  use Nielson.ModelCase

  alias Nielson.Userya

  @valid_attrs %{email: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Userya.changeset(%Userya{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Userya.changeset(%Userya{}, @invalid_attrs)
    refute changeset.valid?
  end
end
