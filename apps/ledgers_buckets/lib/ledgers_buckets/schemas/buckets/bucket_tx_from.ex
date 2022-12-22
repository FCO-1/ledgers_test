defmodule LedgersBuckets.Buckets.BucketTxFrom do
  use Ecto.Schema
  import Ecto.Changeset

  @schema_prefix "ledger_buckets_00_account_book"
  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "bucket_tx_from" do
    field :amount, :decimal
    field :asset, :string
    field :bucket_tx_from_id, :string
    field :owner, :string
    field :type, :string
    field :wallet, :string
    field :weight, :integer

    timestamps(type: :integer, autogenerate: {:erlang,:system_time,[:millisecond]})
  end

  @doc false
  def changeset(bucket_tx_from, attrs) do
    bucket_tx_from
    |> cast(attrs, [:bucket_tx_from_id, :owner, :wallet, :weight, :type, :amount, :asset])
    |> validate_required([:bucket_tx_from_id, :weight, :type, :amount, :asset])
  end
end
