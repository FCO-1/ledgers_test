defmodule Core.Repo.Migrations.CreateUtxio do
  use Ecto.Migration

  def change do
    schema = "transactions"
    table = "utxio"
    create table(:utxio, primary_key: false, prefix: schema) do
      add :id, :binary_id, primary_key: true
      add :object_id, :string
      add :tx_reference_id, :string
      add :size, :numeric
      add :assetmedio, :string

      timestamps(type: :bigint, autogenerate: {:erlang,:system_time,[:millisecond]})
    end
    execute("ALTER TABLE #{schema}.#{table} ALTER COLUMN id SET DEFAULT uuid_generate_v4();","")
    execute("ALTER TABLE #{schema}.#{table} ALTER COLUMN inserted_at SET DEFAULT ((date_part('epoch'::text, CURRENT_TIMESTAMP) * (1000)::double precision))::bigint;","")
    execute("ALTER TABLE #{schema}.#{table} ALTER COLUMN updated_at SET DEFAULT ((date_part('epoch'::text, CURRENT_TIMESTAMP) * (1000)::double precision))::bigint;","")
  end
end
