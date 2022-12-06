defmodule LedgersBuckets.Repo.Migrations.AddConstraints do
  use Ecto.Migration

  def change do
    schema = "buckets"

    create unique_index(:bucket_txs, [:hash], prefix: schema)
  end
end
