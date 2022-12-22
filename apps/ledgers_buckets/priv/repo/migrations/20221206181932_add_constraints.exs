defmodule LedgersBuckets.Repo.Migrations.AddConstraints do
  use Ecto.Migration

  def change do
    schema = "ledger_buckets_00_account_book"

    create unique_index(:bucket_txs, [:hash], prefix: schema)
  end
end
