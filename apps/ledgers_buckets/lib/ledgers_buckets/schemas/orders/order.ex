defmodule LedgersBuckets.Orders.Order do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "orders" do
    field :amount, :decimal
    field :order_id, :string
    field :flags, :string
    field :from, :string
    field :to, :string
    field :extras, :map
    field :owner, :string
    field :state, :string
    field :status, :string
    field :type, :string

    timestamps(type: :integer, autogenerate: {:erlang,:system_time,[:millisecond]})
  end

  @doc false
  def changeset(order, attrs) do
    order
    |> cast(attrs, [:order_id, :flags, :from, :to, :amount, :type, :status, :state, :owner, :extras])
    |> validate_required([:order_id, :flags, :from, :to, :amount, :type, :status, :state, :owner, :extras])
  end
end
