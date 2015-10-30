defmodule Nielson.Post do
  use Nielson.Web, :model

  schema "posts" do
    field :title, :string
    field :slug, :string
    field :summary, :string
    field :body_markdown, :string
    field :body_html, :string
    field :published_at, Ecto.DateTime
    belongs_to :user, Nielson.User
    timestamps

    field :published, :boolean, virtual: true
  end

  @required_fields ~w(title slug summary body_markdown body_html published)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
    |> unique_constraint(:slug)
    |> set_published_at
  end

  defp set_published_at(changeset) do
    if published = get_change(changeset, :published) do
      case published do
        true  -> changeset |> put_change(:published_at, Ecto.DateTime.utc)
        false -> changeset |> put_change(:published_at, nil)
      end
    else
      changeset
    end
  end
end
