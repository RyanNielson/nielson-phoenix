defmodule Nielson.Repo.Migrations.CreatePost do
  use Ecto.Migration

  def change do
    create table(:posts) do
      add :title, :string
      add :slug, :string
      add :summary, :string
      add :body_markdown, :text
      add :body_html, :text
      add :published_at, :datetime
      add :user_id, references(:users)

      timestamps
    end

    create index(:posts, [:user_id])
    create unique_index(:posts, [:slug])
  end
end
