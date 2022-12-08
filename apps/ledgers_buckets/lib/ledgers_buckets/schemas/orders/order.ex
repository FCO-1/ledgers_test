defmodule LedgersBuckets.Orders.Order do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "orders" do
    field :amount, :string
    field :destination, :string
    field :extras, :map
    field :origin, :string
    field :owner, :string
    field :state, :string
    field :status, :string
    field :type, :string

    timestamps()
  end

  @doc false
  def changeset(order, attrs) do
    order
    |> cast(attrs, [:origin, :amount, :type, :status, :state, :owner, :destination, :extras])
    |> validate_required([:origin, :amount, :type, :status, :state, :owner, :destination, :extras])
  end
end
