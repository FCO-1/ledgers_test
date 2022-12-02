defmodule LedgersBuckets.Repo.Migrations.CreateBucketTxs do
  use Ecto.Migration

  def change do
    create table(:bucket_txs, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :bucket_tx_id, :string
      add :bucket_tx_at, :string
      add :type, :string
      add :amount, :decimal
      add :asset, :string
      add :state, :string
      add :status, :string
      add :note, :string
      add :request_id, :string
      add :reference_id, :string
      add :reference_type, :string
      add :hash, :text

      timestamps()
    end
  end
end
