defmodule Core.Transaccions.TxTest do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "tx_tests" do
    field :ammount, :string
    field :owner, :string
    field :reference, :string
    field :tx_table, :string
    field :way, :string

    timestamps()
  end

  @doc false
  def changeset(tx_test, attrs) do
    tx_test
    |> cast(attrs, [:tx_table, :reference, :ammount, :way, :owner])
    |> validate_required([:tx_table, :reference, :ammount, :way, :owner])
  end
end
