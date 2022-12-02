defmodule LedgersBuckets.BucketsTest do
  use LedgersBuckets.DataCase

  alias LedgersBuckets.Buckets

  describe "bucket_txs" do
    alias LedgersBuckets.Buckets.BucketTxs

    import LedgersBuckets.BucketsFixtures

    @invalid_attrs %{amount: nil, asset: nil, bucket_tx_at: nil, bucket_tx_id: nil, hash: nil, note: nil, reference_id: nil, reference_type: nil, request_id: nil, state: nil, status: nil, type: nil}

    test "list_bucket_txs/0 returns all bucket_txs" do
      bucket_txs = bucket_txs_fixture()
      assert Buckets.list_bucket_txs() == [bucket_txs]
    end

    test "get_bucket_txs!/1 returns the bucket_txs with given id" do
      bucket_txs = bucket_txs_fixture()
      assert Buckets.get_bucket_txs!(bucket_txs.id) == bucket_txs
    end

    test "create_bucket_txs/1 with valid data creates a bucket_txs" do
      valid_attrs = %{amount: "120.5", asset: "some asset", bucket_tx_at: "some bucket_tx_at", bucket_tx_id: "some bucket_tx_id", hash: "some hash", note: "some note", reference_id: "some reference_id", reference_type: "some reference_type", request_id: "some request_id", state: "some state", status: "some status", type: "some type"}

      assert {:ok, %BucketTxs{} = bucket_txs} = Buckets.create_bucket_txs(valid_attrs)
      assert bucket_txs.amount == Decimal.new("120.5")
      assert bucket_txs.asset == "some asset"
      assert bucket_txs.bucket_tx_at == "some bucket_tx_at"
      assert bucket_txs.bucket_tx_id == "some bucket_tx_id"
      assert bucket_txs.hash == "some hash"
      assert bucket_txs.note == "some note"
      assert bucket_txs.reference_id == "some reference_id"
      assert bucket_txs.reference_type == "some reference_type"
      assert bucket_txs.request_id == "some request_id"
      assert bucket_txs.state == "some state"
      assert bucket_txs.status == "some status"
      assert bucket_txs.type == "some type"
    end

    test "create_bucket_txs/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Buckets.create_bucket_txs(@invalid_attrs)
    end

    test "update_bucket_txs/2 with valid data updates the bucket_txs" do
      bucket_txs = bucket_txs_fixture()
      update_attrs = %{amount: "456.7", asset: "some updated asset", bucket_tx_at: "some updated bucket_tx_at", bucket_tx_id: "some updated bucket_tx_id", hash: "some updated hash", note: "some updated note", reference_id: "some updated reference_id", reference_type: "some updated reference_type", request_id: "some updated request_id", state: "some updated state", status: "some updated status", type: "some updated type"}

      assert {:ok, %BucketTxs{} = bucket_txs} = Buckets.update_bucket_txs(bucket_txs, update_attrs)
      assert bucket_txs.amount == Decimal.new("456.7")
      assert bucket_txs.asset == "some updated asset"
      assert bucket_txs.bucket_tx_at == "some updated bucket_tx_at"
      assert bucket_txs.bucket_tx_id == "some updated bucket_tx_id"
      assert bucket_txs.hash == "some updated hash"
      assert bucket_txs.note == "some updated note"
      assert bucket_txs.reference_id == "some updated reference_id"
      assert bucket_txs.reference_type == "some updated reference_type"
      assert bucket_txs.request_id == "some updated request_id"
      assert bucket_txs.state == "some updated state"
      assert bucket_txs.status == "some updated status"
      assert bucket_txs.type == "some updated type"
    end

    test "update_bucket_txs/2 with invalid data returns error changeset" do
      bucket_txs = bucket_txs_fixture()
      assert {:error, %Ecto.Changeset{}} = Buckets.update_bucket_txs(bucket_txs, @invalid_attrs)
      assert bucket_txs == Buckets.get_bucket_txs!(bucket_txs.id)
    end

    test "delete_bucket_txs/1 deletes the bucket_txs" do
      bucket_txs = bucket_txs_fixture()
      assert {:ok, %BucketTxs{}} = Buckets.delete_bucket_txs(bucket_txs)
      assert_raise Ecto.NoResultsError, fn -> Buckets.get_bucket_txs!(bucket_txs.id) end
    end

    test "change_bucket_txs/1 returns a bucket_txs changeset" do
      bucket_txs = bucket_txs_fixture()
      assert %Ecto.Changeset{} = Buckets.change_bucket_txs(bucket_txs)
    end
  end

  describe "bucket_tx_from" do
    alias LedgersBuckets.Buckets.BucketTxFrom

    import LedgersBuckets.BucketsFixtures

    @invalid_attrs %{amount: nil, asset: nil, bucket_tx_from_id: nil, owner: nil, type: nil, wallet: nil, weight: nil}

    test "list_bucket_tx_from/0 returns all bucket_tx_from" do
      bucket_tx_from = bucket_tx_from_fixture()
      assert Buckets.list_bucket_tx_from() == [bucket_tx_from]
    end

    test "get_bucket_tx_from!/1 returns the bucket_tx_from with given id" do
      bucket_tx_from = bucket_tx_from_fixture()
      assert Buckets.get_bucket_tx_from!(bucket_tx_from.id) == bucket_tx_from
    end

    test "create_bucket_tx_from/1 with valid data creates a bucket_tx_from" do
      valid_attrs = %{amount: "120.5", asset: "some asset", bucket_tx_from_id: "some bucket_tx_from_id", owner: "some owner", type: "some type", wallet: "some wallet", weight: 42}

      assert {:ok, %BucketTxFrom{} = bucket_tx_from} = Buckets.create_bucket_tx_from(valid_attrs)
      assert bucket_tx_from.amount == Decimal.new("120.5")
      assert bucket_tx_from.asset == "some asset"
      assert bucket_tx_from.bucket_tx_from_id == "some bucket_tx_from_id"
      assert bucket_tx_from.owner == "some owner"
      assert bucket_tx_from.type == "some type"
      assert bucket_tx_from.wallet == "some wallet"
      assert bucket_tx_from.weight == 42
    end

    test "create_bucket_tx_from/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Buckets.create_bucket_tx_from(@invalid_attrs)
    end

    test "update_bucket_tx_from/2 with valid data updates the bucket_tx_from" do
      bucket_tx_from = bucket_tx_from_fixture()
      update_attrs = %{amount: "456.7", asset: "some updated asset", bucket_tx_from_id: "some updated bucket_tx_from_id", owner: "some updated owner", type: "some updated type", wallet: "some updated wallet", weight: 43}

      assert {:ok, %BucketTxFrom{} = bucket_tx_from} = Buckets.update_bucket_tx_from(bucket_tx_from, update_attrs)
      assert bucket_tx_from.amount == Decimal.new("456.7")
      assert bucket_tx_from.asset == "some updated asset"
      assert bucket_tx_from.bucket_tx_from_id == "some updated bucket_tx_from_id"
      assert bucket_tx_from.owner == "some updated owner"
      assert bucket_tx_from.type == "some updated type"
      assert bucket_tx_from.wallet == "some updated wallet"
      assert bucket_tx_from.weight == 43
    end

    test "update_bucket_tx_from/2 with invalid data returns error changeset" do
      bucket_tx_from = bucket_tx_from_fixture()
      assert {:error, %Ecto.Changeset{}} = Buckets.update_bucket_tx_from(bucket_tx_from, @invalid_attrs)
      assert bucket_tx_from == Buckets.get_bucket_tx_from!(bucket_tx_from.id)
    end

    test "delete_bucket_tx_from/1 deletes the bucket_tx_from" do
      bucket_tx_from = bucket_tx_from_fixture()
      assert {:ok, %BucketTxFrom{}} = Buckets.delete_bucket_tx_from(bucket_tx_from)
      assert_raise Ecto.NoResultsError, fn -> Buckets.get_bucket_tx_from!(bucket_tx_from.id) end
    end

    test "change_bucket_tx_from/1 returns a bucket_tx_from changeset" do
      bucket_tx_from = bucket_tx_from_fixture()
      assert %Ecto.Changeset{} = Buckets.change_bucket_tx_from(bucket_tx_from)
    end
  end
end
