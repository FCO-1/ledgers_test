defmodule LedgersBuckets.Repo.Migrations.CreateBucketFlows do
  use Ecto.Migration

  def change do
    schema = "buckets"
    table = "bucket_flows"
    create table(:bucket_flows, primary_key: false, prefix: schema) do
      add :id, :binary_id, primary_key: true
      add :bucket_flow_id, :citext
      add :bucket_tx_id, :citext
      add :amount, :numeric
      add :bucket_in, :citext
      add :bucket_out, :citext


      timestamps(type: :bigint, autogenerate: {:erlang,:system_time,[:millisecond]})
    end
    execute("ALTER TABLE #{schema}.#{table} ALTER COLUMN id SET DEFAULT uuid_generate_v4();","")
    execute("ALTER TABLE #{schema}.#{table} ALTER COLUMN inserted_at SET DEFAULT ((date_part('epoch'::text, CURRENT_TIMESTAMP) * (1000)::double precision))::bigint","")
    execute("ALTER TABLE #{schema}.#{table} ALTER COLUMN updated_at SET DEFAULT ((date_part('epoch'::text, CURRENT_TIMESTAMP) * (1000)::double precision))::bigint","")
  end
end
