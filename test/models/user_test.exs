defmodule Nielson.UserTest do
  use Nielson.ModelCase

  alias Nielson.User

  @valid_attrs %{email: "test@example.com", password: "testpassword", password_confirmation: "testpassword"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = User.changeset(%User{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = User.changeset(%User{}, @invalid_attrs)
    refute changeset.valid?
  end

  test "password_digest value gets set to hash" do
    changeset = User.changeset(%User{}, @valid_attrs)
    assert Comeonin.Bcrypt.checkpw(@valid_attrs.password, Ecto.Changeset.get_change(changeset, :password_digest))
  end

  test "password_digest value does not get set if password is nil" do
    changeset = User.changeset(%User{}, %{@valid_attrs | password: nil, password_confirmation: nil})
    refute Ecto.Changeset.get_change(changeset, :password_digest)
  end
end
