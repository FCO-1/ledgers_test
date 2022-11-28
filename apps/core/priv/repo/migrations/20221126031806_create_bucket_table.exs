defmodule Core.Repo.Migrations.CreateBucketTable do
  use Ecto.Migration

  def change do
    schema = "transactions"
    table = "bucket_table"
    create table(:bucket_table, primary_key: false, prefix: schema) do
      add :id, :binary_id, primary_key: true
      add :bucket_id, :string
      add :ammount, :numeric
      add :asset, :string
      add :owner, :string
      add :state_spent, :string
      add :state_locked, :string
      add :locked_by, :string
      add :hash, :text

      timestamps()
    end
  end
end