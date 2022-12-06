defmodule LedgersBuckets.Repo.Migrations.CreateBucketTxs do
  use Ecto.Migration

  def change do
    schema = "buckets"
    table = "bucket_txs"
    execute "CREATE SCHEMA IF NOT EXISTS #{schema}", "DROP SCHEMA IF EXISTS #{schema}"

    create table(:bucket_txs, primary_key: false, prefix: schema) do
      add :id, :binary_id, primary_key: true
      add :bucket_tx_id, :citext
      add :bucket_tx_at, :naive_datetime
      add :type, :citext
      add :amount, :numeric
      add :asset, :citext
      add :state, :citext
      add :status, :citext
      add :note, :text
      add :request_id, :string
      add :reference_id, :string
      add :reference_type, :string
      add :hash, :binary

      timestamps(type: :bigint, autogenerate: {:erlang,:system_time,[:millisecond]})
    end
    execute("ALTER TABLE #{schema}.#{table} ALTER COLUMN id SET DEFAULT uuid_generate_v4();","")
    execute("ALTER TABLE #{schema}.#{table} ALTER COLUMN inserted_at SET DEFAULT ((date_part('epoch'::text, CURRENT_TIMESTAMP) * (1000)::double precision))::bigint","")
    execute("ALTER TABLE #{schema}.#{table} ALTER COLUMN updated_at SET DEFAULT ((date_part('epoch'::text, CURRENT_TIMESTAMP) * (1000)::double precision))::bigint","")
  end
end
