defmodule Core.Repo.Migrations.CreateTxTests do
  use Ecto.Migration

  def change do
    create table(:tx_tests, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :tx_table, :string
      add :reference, :string
      add :ammount, :string
      add :way, :string
      add :owner, :string

      timestamps()
    end
  end
end
