defmodule LedgersBuckets.BucketsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `LedgersBuckets.Buckets` context.
  """
alias String.Chars.NaiveDateTime
alias NaiveDateTime, as: TimeLocal

  @doc """
  Generate a bucket_txs.
  """
  def bucket_txs_fixture(attrs \\ %{}) do
    {:ok, bucket_txs} =
      attrs
      |> Enum.into(%{
        amount: "120.5",
        asset: "MXN",
        bucket_tx_at: TimeLocal.local_now(),
        bucket_tx_id: "bucket_txs_1000",
        hash: "pfDSEwew34234efsdfDFSGhh664534gsgfh547534342fsgdg",
        note: "some note",
        reference_id: "111232",
        reference_type: "order",
        request_id: "some request_id",
        state: "complete",
        status: "close",
        type: "complete"
      })
      |> LedgersBuckets.Buckets.create_bucket_txs()

    bucket_txs
  end

  @doc """
  Generate a bucket_tx_from.
  """
  def bucket_tx_from_fixture(attrs \\ %{}) do
    {:ok, bucket_tx_from} =
      attrs
      |> Enum.into(%{
        amount: "120.5",
        asset: "some asset",
        bucket_tx_from_id: "some bucket_tx_from_id",
        owner: "some owner",
        type: "some type",
        wallet: "some wallet",
        weight: 42
      })
      |> LedgersBuckets.Buckets.create_bucket_tx_from()

    bucket_tx_from
  end

  @doc """
  Generate a bucket_tx_to.
  """
  def bucket_tx_to_fixture(attrs \\ %{}) do
    {:ok, bucket_tx_to} =
      attrs
      |> Enum.into(%{
        amount: "120.5",
        assets: "some assets",
        bucket_tx_id: "some bucket_tx_id",
        onwer: "some onwer",
        wallet: "some wallet"
      })
      |> LedgersBuckets.Buckets.create_bucket_tx_to()

    bucket_tx_to
  end

  @doc """
  Generate a bucket.
  """
  def bucket_fixture(attrs \\ %{}) do
    {:ok, bucket} =
      attrs
      |> Enum.into(%{
        amount: "120.5",
        asset: "some asset",
        asset_reference: "some asset_reference",
        asset_type: "some asset_type",
        bucket_at: ~N[2022-12-01 20:37:00],
        bucket_id: "some bucket_id",
        bucket_tx_id: "some bucket_tx_id",
        is_spent: 42,
        lock_4_tx: 42,
        locked_at: ~N[2022-12-01 20:37:00],
        locked_by_tx_id: "some locked_by_tx_id",
        owner: "some owner",
        spent_at: ~N[2022-12-01 20:37:00],
        type: "some type",
        wallet: "some wallet"
      })
      |> LedgersBuckets.Buckets.create_bucket()

    bucket
  end

  @doc """
  Generate a bucket_flow.
  """
  def bucket_flow_fixture(attrs \\ %{}) do
    {:ok, bucket_flow} =
      attrs
      |> Enum.into(%{
        amount: "120.5",
        bucket_flow_id: "some bucket_flow_id",
        bucket_in: "some bucket_in",
        bucket_out: "some bucket_out",
        bucket_tx_id: "some bucket_tx_id"
      })
      |> LedgersBuckets.Buckets.create_bucket_flow()

    bucket_flow
  end

  def bucket_transaction_for_expand_fixture do
      map = %{
        "amount" => "800",
        "asset" => "MXN",
        "bucket_tx_at" => "2022-12-06T21:43",
        "note" => "cliente cliente",
        "owner_from" => "cliente25",
        "owner_to" => "cliente25",
        "reference_id" => "Or221",
        "reference_type" => "order",
        "request_id" => "1224123",
        "state" => "pending",
        "status" => "open",
        "type" => "expand",
        "wallet_from" => "iri.efectivo",
        "wallet_to" => "irl.efectivo"
      }

      list = [
        %{
          "amount" => 200,
          "asset" => "MXN",
          "is_spent" => 0,
          "lock_4_tx" => 0,
          "owner_to" => "cliente 25",
          "wallet_to" => "ilr.cash"
        },
        %{
          "amount" => 800,
          "asset" => "MXN",
          "is_spent" => 0,
          "lock_4_tx" => 0,
          "owner_to" => "cliente 25",
          "wallet_to" => "ilr.cash"
        },

      ]
      bucket_in = LedgersBuckets.Buckets.get_bucket!("51daa1bc-96a4-4183-8ef7-454f8d8272c3")
      LedgersBuckets.Domain.BucketsDomain.create_new_bucket_transaction_for_expand(map, bucket_in, list)

    end

  def bucket_transaction_new_bucket do
      map = %{
        "amount" => "800",
        "asset" => "MXN",
        "bucket_tx_at" => "2022-12-06T21:43",
        "note" => "cliente cliente",
        "owner_from" => "cliente25",
        "owner_to" => "cliente25",
        "reference_id" => "Or221",
        "reference_type" => "order",
        "request_id" => "1224123",
        "state" => "pending",
        "status" => "open",
        "type" => "expand",
        "wallet_from" => "iri.efectivo",
        "wallet_to" => "irl.efectivo"
      }
      LedgersBuckets.Domain.BucketsDomain.create_new_bucket_transaction(map)

    end

    def test_new_bucket_swap do
      map = %{
        "amount" => "",
        "asset" => "MXN",
        "bucket_tx_at" => "2022-12-06T21:43",
        "note" => "cliente cliente",
        "owner_from" => "cliente25",
        "owner_to" => "cliente25",
        "reference_id" => "Or221",
        "reference_type" => "order",
        "request_id" => "1224123",
        "state" => "pending",
        "status" => "open",
        "type" => "swap",
        "wallet_from" => "cmd.mint",
        "wallet_to" => "irl.efectivo",
        "is_spent" => 0,
        "locket_4_tx" => 1,
      }


      LedgersBuckets.Domain.BucketsDomain.create_new_buckets_for_swap(map, ["bucket_1002", "bucket_1003", "bucket_1004"])

    end
end
