defmodule LedgersBuckets.Orders.OrderBucketTxs do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "order_bucket_txs" do
    field :order_id, :string
    field :reference_id, :string
    field :reference_type, :string

    timestamps(type: :integer, autogenerate: {:erlang,:system_time,[:millisecond]})
  end

  @doc false
  def changeset(order_bucket_txs, attrs) do
    order_bucket_txs
    |> cast(attrs, [:order_id, :reference_type, :reference_id])
    |> validate_required([:order_id, :reference_type, :reference_id])
  end
end
