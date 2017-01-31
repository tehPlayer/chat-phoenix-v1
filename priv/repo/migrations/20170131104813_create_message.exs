defmodule ChatPhoenix.Repo.Migrations.CreateMessage do
  use Ecto.Migration

  def change do
    create table(:messages) do
      add :author, :string
      add :body, :text

      timestamps()
    end

  end
end
