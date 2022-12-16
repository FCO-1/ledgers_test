defmodule LedgersBuckets.Repo.Migrations.CreateOrders do
  use Ecto.Migration

  def change do
    schema = "buckets"
    table = "orders"
    create table(:orders, primary_key: false, prefix: schema) do
      add :id, :binary_id, primary_key: true
      add :order_id, :citext
      add :amount, :numeric
      add :flags, :citext
      add :type, :citext
      add :status, :citext
      add :state, :citext
      add :owner, :citext
      add :from, :citext
      add :to, :citext
      add :extras, :map

      timestamps(type: :bigint, autogenerate: {:erlang,:system_time,[:millisecond]})
    end
    execute "CREATE SEQUENCE #{schema}.order_sequence start with 1000;", "DROP SEQUENCE IF EXISTS #{schema}.bucket_flow_sequence;"

    execute("ALTER TABLE #{schema}.#{table} ALTER COLUMN id SET DEFAULT uuid_generate_v4();","")
    execute("ALTER TABLE #{schema}.#{table} ALTER COLUMN inserted_at SET DEFAULT ((date_part('epoch'::text, CURRENT_TIMESTAMP) * (1000)::double precision))::bigint","")
    execute("ALTER TABLE #{schema}.#{table} ALTER COLUMN updated_at SET DEFAULT ((date_part('epoch'::text, CURRENT_TIMESTAMP) * (1000)::double precision))::bigint","")
  end
end
