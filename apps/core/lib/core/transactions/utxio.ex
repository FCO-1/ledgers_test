defmodule Core.Transactions.Utxio do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "utxio" do
    field :assetmedio, :string
    field :object_id, :string
    field :size, :decimal
    field :tx_reference_id, :string

    timestamps()
  end

  @doc false
  def changeset(utxio, attrs) do
    utxio
    |> cast(attrs, [:object_id, :tx_reference_id, :size, :assetmedio])
    |> validate_required([:object_id, :tx_reference_id, :size, :assetmedio])
  end
end
