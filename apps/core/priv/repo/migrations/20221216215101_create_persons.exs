defmodule Core.Repo.Migrations.CreatePersons do
  use Ecto.Migration

  def change do
    create table(:persons, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :alias, :string
      add :name, :string

      timestamps()
    end
  end
end
