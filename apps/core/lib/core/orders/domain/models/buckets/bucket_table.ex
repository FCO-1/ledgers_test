defmodule Core.Buckets.BucketTable do
  use Ecto.Schema
  import Ecto.Changeset

  @schema_prefix "transactions"
  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "bucket_table" do
    field :ammount, :decimal
    field :asset, :string
    field :bucket_id, :string
    field :hash, :string
    field :locked_by, :string
    field :owner, :string
    field :state_locked, :string
    field :state_spent, :string

    timestamps()
  end

  @doc false
  def changeset(bucket_table, attrs) do
    bucket_table
    |> cast(attrs, [:bucket_id, :ammount, :asset, :owner, :state_spent, :state_locked, :locked_by, :hash])
    |> validate_required([:bucket_id, :ammount, :asset, :owner, :state_spent, :state_locked, :locked_by, :hash])
  end
end
