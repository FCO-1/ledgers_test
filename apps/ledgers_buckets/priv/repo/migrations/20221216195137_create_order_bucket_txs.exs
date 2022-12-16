defmodule LedgersBuckets.Repo.Migrations.CreateOrderBucketTxs do
  use Ecto.Migration

  def change do
    create table(:order_bucket_txs, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :order_id, :string
      add :reference_type, :string
      add :reference_id, :string

      timestamps()
    end
  end
end
