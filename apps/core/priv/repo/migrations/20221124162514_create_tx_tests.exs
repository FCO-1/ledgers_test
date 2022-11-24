defmodule Core.Repo.Migrations.CreateTxTests do
  use Ecto.Migration

  def change do
    schema = "transactions"
    table = "tx_tests"
    create table(:tx_tests, primary_key: false, prefix: schema) do
      add :id, :binary_id, primary_key: true
      add :tx_table, :string
      add :reference, :string
      add :ammount, :numeric
      add :way, :string
      add :owner, :string

      timestamps()
    end
  end
end
