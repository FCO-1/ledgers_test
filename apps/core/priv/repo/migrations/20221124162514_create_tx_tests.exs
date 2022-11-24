defmodule Core.Repo.Migrations.CreateTxTests do
  use Ecto.Migration

  def change do
    schema = "transactions"
    table = "tx_tests"
    execute "CREATE SCHEMA #{schema}", "DROP SCHEMA IF EXISTS #{schema}"
    create table(:tx_tests, primary_key: false, prefix: schema) do
      add :id, :binary_id, primary_key: true
      add :tx_table, :string
      add :reference, :string
      add :in, :string
      add :out, :string
      add :ammount, :numeric
      add :way, :string
      add :owner, :string

      timestamps(type: :bigint, autogenerate: {:erlang,:system_time,[:millisecond]})
    end

    execute("ALTER TABLE #{schema}.#{table} ALTER COLUMN id SET DEFAULT uuid_generate_v4();","")
    execute("ALTER TABLE #{schema}.#{table} ALTER COLUMN inserted_at SET DEFAULT ((date_part('epoch'::text, CURRENT_TIMESTAMP) * (1000)::double precision))::bigint;","")
    execute("ALTER TABLE #{schema}.#{table} ALTER COLUMN updated_at SET DEFAULT ((date_part('epoch'::text, CURRENT_TIMESTAMP) * (1000)::double precision))::bigint;","")
  end
end
