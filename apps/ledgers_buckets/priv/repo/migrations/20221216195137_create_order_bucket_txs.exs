defmodule LedgersBuckets.Repo.Migrations.CreateOrderBucketTxs do
  use Ecto.Migration

  def change do
    schema = "buckets"
    table = "order_bucket_txs"
    create table(:order_bucket_txs, primary_key: false, prefix: schema) do
      add :id, :binary_id, primary_key: true
      add :order_id, :string
      add :reference_type, :string
      add :reference_id, :string

      timestamps(type: :bigint, autogenerate: {:erlang,:system_time,[:millisecond]})
    end

    execute "CREATE SEQUENCE #{schema}.order_bucket_txs_sequence start with 1000;", "DROP SEQUENCE IF EXISTS #{schema}.order_bucket_txs_sequence;"

    execute("ALTER TABLE #{schema}.#{table} ALTER COLUMN id SET DEFAULT uuid_generate_v4();","")
    execute("ALTER TABLE #{schema}.#{table} ALTER COLUMN inserted_at SET DEFAULT ((date_part('epoch'::text, CURRENT_TIMESTAMP) * (1000)::double precision))::bigint","")
    execute("ALTER TABLE #{schema}.#{table} ALTER COLUMN updated_at SET DEFAULT ((date_part('epoch'::text, CURRENT_TIMESTAMP) * (1000)::double precision))::bigint","")
  end
end
