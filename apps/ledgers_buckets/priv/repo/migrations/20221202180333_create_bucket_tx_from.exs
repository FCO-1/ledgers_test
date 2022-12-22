defmodule LedgersBuckets.Repo.Migrations.CreateBucketTxFrom do
  use Ecto.Migration

  def change do
    schema = "ledger_buckets_00_account_book"
    table = "bucket_tx_from"
    create table(:bucket_tx_from, primary_key: false, prefix: schema) do
      add :id, :binary_id, primary_key: true
      add :bucket_tx_from_id, :string
      add :bucket_tx_id, references(:bucket_txs, prefix: schema, type: :binary_id, on_delete: :delete_all), null: false
      add :owner, :string
      add :wallet, :string
      add :weight, :integer
      add :type, :string
      add :amount, :numeric
      add :asset, :string

      timestamps(type: :bigint, autogenerate: {:erlang,:system_time,[:millisecond]})
    end
    execute("ALTER TABLE #{schema}.#{table} ALTER COLUMN id SET DEFAULT uuid_generate_v4();","")
    execute("ALTER TABLE #{schema}.#{table} ALTER COLUMN inserted_at SET DEFAULT ((date_part('epoch'::text, CURRENT_TIMESTAMP) * (1000)::double precision))::bigint","")
    execute("ALTER TABLE #{schema}.#{table} ALTER COLUMN updated_at SET DEFAULT ((date_part('epoch'::text, CURRENT_TIMESTAMP) * (1000)::double precision))::bigint","")
  end
end
