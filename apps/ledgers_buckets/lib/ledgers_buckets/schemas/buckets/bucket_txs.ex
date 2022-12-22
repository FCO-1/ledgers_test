defmodule LedgersBuckets.Buckets.BucketTxs do
  use Ecto.Schema
  import Ecto.Changeset

  @schema_prefix "ledger_buckets_00_account_book"
  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "bucket_txs" do
    field :amount, :decimal
    field :asset, :string
    field :bucket_tx_at, :naive_datetime
    field :bucket_tx_id, :string
    field :hash, :binary
    field :note, :string
    field :reference_id, :string
    field :reference_type, :string
    field :request_id, :string
    field :state, :string
    field :status, :string
    field :type, :string

    timestamps(type: :integer, autogenerate: {:erlang,:system_time,[:millisecond]})
  end

  @doc false
  def changeset(bucket_txs, attrs) do
    bucket_txs
    |> cast(attrs, [:bucket_tx_id, :bucket_tx_at, :type, :amount, :asset, :state, :status, :note, :request_id, :reference_id, :reference_type, :hash])
    |> validate_required([:bucket_tx_id, :bucket_tx_at, :type, :amount, :asset, :state, :status, :note, :request_id, :reference_id, :reference_type, :hash])
    |> unique_constraint(:hash, name: "bucket_txs_hash_index")
  end
end
