defmodule LedgersBuckets.AccountBooks.Wallet do
  use Ecto.Schema
  import Ecto.Changeset

  @schema_prefix "ledger_buckets_00_account_book"
  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "wallets" do
    field :extras, :map, default: %{}
    field :name, :string
    field :node, :string
    field :path, :string
    field :state, :string
    field :weight, :integer

    timestamps(type: :integer, autogenerate: {:erlang,:system_time,[:millisecond]})
  end

  @doc false
  def changeset(wallet, attrs) do
    wallet
    |> cast(attrs, [:path, :node, :name, :state, :weight, :extras])
    |> validate_required([:path, :node, :name, :state])
  end
end
