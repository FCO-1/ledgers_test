defmodule LedgersBuckets.Buckets.Bucket do
  use Ecto.Schema
  import Ecto.Changeset

  @schema_prefix "ledger_buckets_00_account_book"
  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "buckets" do
    field :amount, :decimal
    field :asset, :string
    field :asset_reference, :string
    field :asset_type, :string
    field :bucket_at, :naive_datetime
    field :bucket_id, :string
    field :bucket_tx_id, :string
    field :is_spent, :integer
    field :lock_4_tx, :integer
    field :locked_at, :naive_datetime
    field :locked_by_tx_id, :string
    field :owner, :string
    field :spent_at, :naive_datetime
    field :type, :string
    field :wallet, :string

    timestamps(type: :integer, autogenerate: {:erlang,:system_time,[:millisecond]})
  end

  @doc false
  def changeset(bucket, attrs) do
    bucket
    |> cast(attrs, [:bucket_id, :bucket_at, :bucket_tx_id, :owner, :wallet, :type, :amount, :asset, :asset_type, :asset_reference, :is_spent, :lock_4_tx, :locked_by_tx_id, :locked_at, :spent_at])
    |> validate_required([:bucket_id, :bucket_at, :bucket_tx_id, :owner, :wallet, :type, :amount, :asset, :asset_type, :asset_reference, :is_spent, :lock_4_tx, :locked_by_tx_id, :locked_at, :spent_at])
  end
end
