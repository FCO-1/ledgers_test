defmodule LedgersBuckets.Buckets.BucketTxTo do
  use Ecto.Schema
  import Ecto.Changeset

  @schema_prefix "ledger_buckets_00_account_book"
  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "bucket_tx_to" do
    field :amount, :decimal
    field :assets, :string
    field :bucket_tx_id, :string
    field :onwer, :string
    field :wallet, :string

    timestamps(type: :integer, autogenerate: {:erlang,:system_time,[:millisecond]})
  end

  @doc false
  def changeset(bucket_tx_to, attrs) do
    bucket_tx_to
    |> cast(attrs, [:bucket_tx_id, :onwer, :wallet, :amount, :assets])
    |> validate_required([:bucket_tx_id, :onwer, :wallet, :amount, :assets])
  end
end
