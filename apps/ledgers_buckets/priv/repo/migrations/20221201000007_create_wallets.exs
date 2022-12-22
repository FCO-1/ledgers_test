defmodule LedgersBuckets.Repo.Migrations.CreateWallets do
  use Ecto.Migration

  def change do
    schema = "ledger_buckets_00_account_book"
    table = "wallets"
    execute "CREATE SCHEMA IF NOT EXISTS #{schema}", "DROP SCHEMA IF EXISTS #{schema} CASCADE"
    create table(:wallets, primary_key: false, prefix: schema) do
      add :id, :binary_id, primary_key: true
      add :path, :string
      add :node, :string
      add :name, :string
      add :state, :string
      add :weight, :integer
      add :extras, :jsonb, default: "{}"

      timestamps(type: :bigint, autogenerate: {:erlang,:system_time,[:millisecond]})
    end

    execute("ALTER TABLE #{schema}.#{table} ALTER COLUMN id SET DEFAULT uuid_generate_v4();","")
    execute("ALTER TABLE #{schema}.#{table} ALTER COLUMN inserted_at SET DEFAULT ((date_part('epoch'::text, CURRENT_TIMESTAMP) * (1000)::double precision))::bigint","")
    execute("ALTER TABLE #{schema}.#{table} ALTER COLUMN updated_at SET DEFAULT ((date_part('epoch'::text, CURRENT_TIMESTAMP) * (1000)::double precision))::bigint","")
  end
end
