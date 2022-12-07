defmodule LedgersBuckets.Repo.Migrations.CreateOrders do
  use Ecto.Migration

  def change do
    create table(:orders, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :origin, :string
      add :amount, :string
      add :type, :string
      add :status, :string
      add :state, :string
      add :owner, :string
      add :destination, :string
      add :extras, :map

      timestamps()
    end
  end
end
