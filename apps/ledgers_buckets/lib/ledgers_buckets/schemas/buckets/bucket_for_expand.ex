defmodule LedgersBuckets.Schemas.Buckets.BucketForExpand do
  use Ecto.Schema
  import Ecto.Changeset

  embedded_schema do
    field :wallet_to, :string
    field :owner_to, :string
    field :amount, :decimal
    field :asset, :string
    field :lock_4_tx, :integer
    field :is_spent, :integer
  end

  def changeset(bucket_for_expand, attrs) do
    bucket_for_expand
    |> cast(attrs, [:wallet_to, :owner_to, :amount, :asset, :lock_4_tx, :is_spent])
    |> validate_required([:wallet_to, :owner_to, :amount, :asset])
  end
end
