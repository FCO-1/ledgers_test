defmodule LedgersBuckets.BucketsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `LedgersBuckets.Buckets` context.
  """

  @doc """
  Generate a bucket_txs.
  """
  def bucket_txs_fixture(attrs \\ %{}) do
    {:ok, bucket_txs} =
      attrs
      |> Enum.into(%{
        amount: "120.5",
        asset: "some asset",
        bucket_tx_at: "some bucket_tx_at",
        bucket_tx_id: "some bucket_tx_id",
        hash: "some hash",
        note: "some note",
        reference_id: "some reference_id",
        reference_type: "some reference_type",
        request_id: "some request_id",
        state: "some state",
        status: "some status",
        type: "some type"
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
end
