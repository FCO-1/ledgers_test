defmodule LedgersBuckets.Repo.Migrations.CreateOrders do
  use Ecto.Migration

  def change do
    schema = "buckets"
    table = "orders"
    create table(:orders, primary_key: false, prefix: schema) do
      add :id, :binary_id, primary_key: true
      add :origin, :citext
      add :amount, :numeric
      add :type, :citext
      add :status, :citext
      add :state, :citext
      add :owner, :citext
      add :destination, :citext
      add :extras, :map

      timestamps()
    end
  end
end
