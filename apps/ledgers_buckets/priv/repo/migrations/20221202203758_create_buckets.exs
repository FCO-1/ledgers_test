defmodule LedgersBuckets.Repo.Migrations.CreateBuckets do
  use Ecto.Migration

  def change do
    schema = "ledger_buckets_00_account_book"
    table = "buckets"
    create table(:buckets, primary_key: false, prefix: schema) do
      add :id, :binary_id, primary_key: true
      add :bucket_id, :string
      add :bucket_at, :naive_datetime
      add :bucket_tx_id, :string
      add :owner, :citext
      add :wallet, :citext
      add :type, :citext
      add :amount, :numeric
      add :asset, :citext
      add :asset_type, :citext
      add :asset_reference, :citext
      add :is_spent, :integer
      add :lock_4_tx, :integer
      add :locked_by_tx_id, :string
      add :locked_at, :naive_datetime
      add :spent_at, :naive_datetime


      timestamps(type: :bigint, autogenerate: {:erlang,:system_time,[:millisecond]})
    end
    execute("ALTER TABLE #{schema}.#{table} ALTER COLUMN id SET DEFAULT uuid_generate_v4();","")
    execute("ALTER TABLE #{schema}.#{table} ALTER COLUMN inserted_at SET DEFAULT ((date_part('epoch'::text, CURRENT_TIMESTAMP) * (1000)::double precision))::bigint","")
    execute("ALTER TABLE #{schema}.#{table} ALTER COLUMN updated_at SET DEFAULT ((date_part('epoch'::text, CURRENT_TIMESTAMP) * (1000)::double precision))::bigint","")
  end
end
