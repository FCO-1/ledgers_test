defmodule LedgersBuckets.Buckets.BucketFlow do
  use Ecto.Schema
  import Ecto.Changeset

  @schema_prefix "ledger_buckets_00_account_book"
  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "bucket_flows" do
    field :amount, :decimal
    field :bucket_flow_id, :string
    field :bucket_in, :string
    field :bucket_out, :string
    field :bucket_tx_id, :string

    timestamps(type: :integer, autogenerate: {:erlang,:system_time,[:millisecond]})
  end

  @doc false
  def changeset(bucket_flow, attrs) do
    bucket_flow
    |> cast(attrs, [:bucket_flow_id, :bucket_tx_id, :amount, :bucket_in, :bucket_out])
    |> validate_required([:bucket_flow_id, :bucket_tx_id, :amount])
  end
end
