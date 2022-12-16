defmodule Core.Repo.Migrations.CreatePersons do
  use Ecto.Migration

  def change do
    schema = "entities"
    table = "persons"
    execute "CREATE SCHEMA IF NOT EXISTS #{schema}", "DROP SCHEMA IF EXISTS #{schema} CASCADE"
    create table(:persons, primary_key: false, prefix: schema) do
      add :id, :binary_id, primary_key: true
      add :alias, :string
      add :name, :string

      timestamps()
    end
    execute("ALTER TABLE #{schema}.#{table} ALTER COLUMN id SET DEFAULT uuid_generate_v4();","")
    #execute("ALTER TABLE #{schema}.#{table} ALTER COLUMN inserted_at SET DEFAULT ((date_part('epoch'::text, CURRENT_TIMESTAMP) * (1000)::double precision))::bigint","")
    #execute("ALTER TABLE #{schema}.#{table} ALTER COLUMN updated_at SET DEFAULT ((date_part('epoch'::text, CURRENT_TIMESTAMP) * (1000)::double precision))::bigint","")
  end
end
