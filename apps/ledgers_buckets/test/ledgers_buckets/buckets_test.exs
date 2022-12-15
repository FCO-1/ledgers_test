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
      date = NaiveDateTime.local_now()
      valid_attrs = %{amount: "120.5", asset: "MXN", bucket_tx_at: date, bucket_tx_id: "bucket_txs_1000", hash: "pfDSEwew34234efsdfDFSGhh664534gsgfh547534342fsgdg", note: "some note", reference_id: "112112", reference_type: "order", request_id: "some request_id", state: "complete", status: "close", type: "mint"}

      map = Buckets.build_bucket_txs(valid_attrs)

      assert {:ok, %BucketTxs{} = bucket_txs} = Buckets.create_bucket_txs(valid_attrs)
      assert bucket_txs.amount == Decimal.new("120.5")
      assert bucket_txs.asset == "MXN"
      assert bucket_txs.bucket_tx_at == date
      assert bucket_txs.bucket_tx_id == "bucket_txs_1000"
      assert bucket_txs.hash == "pfDSEwew34234efsdfDFSGhh664534gsgfh547534342fsgdg"
      assert bucket_txs.note == "some note"
      assert bucket_txs.reference_id == "112112"
      assert bucket_txs.reference_type == "order"
      assert bucket_txs.request_id == "some request_id"
      assert bucket_txs.state == "complete"
      assert bucket_txs.status == "close"
      assert bucket_txs.type == "mint"
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

    #test "update_bucket_txs/2 with invalid data returns error changeset" do
    #  bucket_txs = bucket_txs_fixture()
    #  assert {:error, %Ecto.Changeset{}} = Buckets.update_bucket_txs(bucket_txs, @invalid_attrs)
    #  assert bucket_txs == Buckets.get_bucket_txs!(bucket_txs.id)
    #end

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

  describe "bucket_tx_to" do
    alias LedgersBuckets.Buckets.BucketTxTo

    import LedgersBuckets.BucketsFixtures

    @invalid_attrs %{amount: nil, assets: nil, bucket_tx_id: nil, onwer: nil, wallet: nil}

    test "list_bucket_tx_to/0 returns all bucket_tx_to" do
      bucket_tx_to = bucket_tx_to_fixture()
      assert Buckets.list_bucket_tx_to() == [bucket_tx_to]
    end

    test "get_bucket_tx_to!/1 returns the bucket_tx_to with given id" do
      bucket_tx_to = bucket_tx_to_fixture()
      assert Buckets.get_bucket_tx_to!(bucket_tx_to.id) == bucket_tx_to
    end

    test "create_bucket_tx_to/1 with valid data creates a bucket_tx_to" do
      valid_attrs = %{amount: "120.5", assets: "some assets", bucket_tx_id: "some bucket_tx_id", onwer: "some onwer", wallet: "some wallet"}

      assert {:ok, %BucketTxTo{} = bucket_tx_to} = Buckets.create_bucket_tx_to(valid_attrs)
      assert bucket_tx_to.amount == Decimal.new("120.5")
      assert bucket_tx_to.assets == "some assets"
      assert bucket_tx_to.bucket_tx_id == "some bucket_tx_id"
      assert bucket_tx_to.onwer == "some onwer"
      assert bucket_tx_to.wallet == "some wallet"
    end

    test "create_bucket_tx_to/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Buckets.create_bucket_tx_to(@invalid_attrs)
    end

    test "update_bucket_tx_to/2 with valid data updates the bucket_tx_to" do
      bucket_tx_to = bucket_tx_to_fixture()
      update_attrs = %{amount: "456.7", assets: "some updated assets", bucket_tx_id: "some updated bucket_tx_id", onwer: "some updated onwer", wallet: "some updated wallet"}

      assert {:ok, %BucketTxTo{} = bucket_tx_to} = Buckets.update_bucket_tx_to(bucket_tx_to, update_attrs)
      assert bucket_tx_to.amount == Decimal.new("456.7")
      assert bucket_tx_to.assets == "some updated assets"
      assert bucket_tx_to.bucket_tx_id == "some updated bucket_tx_id"
      assert bucket_tx_to.onwer == "some updated onwer"
      assert bucket_tx_to.wallet == "some updated wallet"
    end

    test "update_bucket_tx_to/2 with invalid data returns error changeset" do
      bucket_tx_to = bucket_tx_to_fixture()
      assert {:error, %Ecto.Changeset{}} = Buckets.update_bucket_tx_to(bucket_tx_to, @invalid_attrs)
      assert bucket_tx_to == Buckets.get_bucket_tx_to!(bucket_tx_to.id)
    end

    test "delete_bucket_tx_to/1 deletes the bucket_tx_to" do
      bucket_tx_to = bucket_tx_to_fixture()
      assert {:ok, %BucketTxTo{}} = Buckets.delete_bucket_tx_to(bucket_tx_to)
      assert_raise Ecto.NoResultsError, fn -> Buckets.get_bucket_tx_to!(bucket_tx_to.id) end
    end

    test "change_bucket_tx_to/1 returns a bucket_tx_to changeset" do
      bucket_tx_to = bucket_tx_to_fixture()
      assert %Ecto.Changeset{} = Buckets.change_bucket_tx_to(bucket_tx_to)
    end
  end

  describe "buckets" do
    alias LedgersBuckets.Buckets.Bucket

    import LedgersBuckets.BucketsFixtures

    @invalid_attrs %{amount: nil, asset: nil, asset_reference: nil, asset_type: nil, bucket_at: nil, bucket_id: nil, bucket_tx_id: nil, is_spent: nil, lock_4_tx: nil, locked_at: nil, locked_by_tx_id: nil, owner: nil, spent_at: nil, type: nil, wallet: nil}

    test "list_buckets/0 returns all buckets" do
      bucket = bucket_fixture()
      assert Buckets.list_buckets() == [bucket]
    end

    test "get_bucket!/1 returns the bucket with given id" do
      bucket = bucket_fixture()
      assert Buckets.get_bucket!(bucket.id) == bucket
    end

    test "create_bucket/1 with valid data creates a bucket" do
      valid_attrs = %{amount: "120.5", asset: "some asset", asset_reference: "some asset_reference", asset_type: "some asset_type", bucket_at: ~N[2022-12-01 20:37:00], bucket_id: "some bucket_id", bucket_tx_id: "some bucket_tx_id", is_spent: 42, lock_4_tx: 42, locked_at: ~N[2022-12-01 20:37:00], locked_by_tx_id: "some locked_by_tx_id", owner: "some owner", spent_at: ~N[2022-12-01 20:37:00], type: "some type", wallet: "some wallet"}

      assert {:ok, %Bucket{} = bucket} = Buckets.create_bucket(valid_attrs)
      assert bucket.amount == Decimal.new("120.5")
      assert bucket.asset == "some asset"
      assert bucket.asset_reference == "some asset_reference"
      assert bucket.asset_type == "some asset_type"
      assert bucket.bucket_at == ~N[2022-12-01 20:37:00]
      assert bucket.bucket_id == "some bucket_id"
      assert bucket.bucket_tx_id == "some bucket_tx_id"
      assert bucket.is_spent == 42
      assert bucket.lock_4_tx == 42
      assert bucket.locked_at == ~N[2022-12-01 20:37:00]
      assert bucket.locked_by_tx_id == "some locked_by_tx_id"
      assert bucket.owner == "some owner"
      assert bucket.spent_at == ~N[2022-12-01 20:37:00]
      assert bucket.type == "some type"
      assert bucket.wallet == "some wallet"
    end

    test "create_bucket/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Buckets.create_bucket(@invalid_attrs)
    end

    test "update_bucket/2 with valid data updates the bucket" do
      bucket = bucket_fixture()
      update_attrs = %{amount: "456.7", asset: "some updated asset", asset_reference: "some updated asset_reference", asset_type: "some updated asset_type", bucket_at: ~N[2022-12-02 20:37:00], bucket_id: "some updated bucket_id", bucket_tx_id: "some updated bucket_tx_id", is_spent: 43, lock_4_tx: 43, locked_at: ~N[2022-12-02 20:37:00], locked_by_tx_id: "some updated locked_by_tx_id", owner: "some updated owner", spent_at: ~N[2022-12-02 20:37:00], type: "some updated type", wallet: "some updated wallet"}

      assert {:ok, %Bucket{} = bucket} = Buckets.update_bucket(bucket, update_attrs)
      assert bucket.amount == Decimal.new("456.7")
      assert bucket.asset == "some updated asset"
      assert bucket.asset_reference == "some updated asset_reference"
      assert bucket.asset_type == "some updated asset_type"
      assert bucket.bucket_at == ~N[2022-12-02 20:37:00]
      assert bucket.bucket_id == "some updated bucket_id"
      assert bucket.bucket_tx_id == "some updated bucket_tx_id"
      assert bucket.is_spent == 43
      assert bucket.lock_4_tx == 43
      assert bucket.locked_at == ~N[2022-12-02 20:37:00]
      assert bucket.locked_by_tx_id == "some updated locked_by_tx_id"
      assert bucket.owner == "some updated owner"
      assert bucket.spent_at == ~N[2022-12-02 20:37:00]
      assert bucket.type == "some updated type"
      assert bucket.wallet == "some updated wallet"
    end

    test "update_bucket/2 with invalid data returns error changeset" do
      bucket = bucket_fixture()
      assert {:error, %Ecto.Changeset{}} = Buckets.update_bucket(bucket, @invalid_attrs)
      assert bucket == Buckets.get_bucket!(bucket.id)
    end

    test "delete_bucket/1 deletes the bucket" do
      bucket = bucket_fixture()
      assert {:ok, %Bucket{}} = Buckets.delete_bucket(bucket)
      assert_raise Ecto.NoResultsError, fn -> Buckets.get_bucket!(bucket.id) end
    end

    test "change_bucket/1 returns a bucket changeset" do
      bucket = bucket_fixture()
      assert %Ecto.Changeset{} = Buckets.change_bucket(bucket)
    end
  end

  describe "bucket_flows" do
    alias LedgersBuckets.Buckets.BucketFlow

    import LedgersBuckets.BucketsFixtures

    @invalid_attrs %{amount: nil, bucket_flow_id: nil, bucket_in: nil, bucket_out: nil, bucket_tx_id: nil}

    test "list_bucket_flows/0 returns all bucket_flows" do
      bucket_flow = bucket_flow_fixture()
      assert Buckets.list_bucket_flows() == [bucket_flow]
    end

    test "get_bucket_flow!/1 returns the bucket_flow with given id" do
      bucket_flow = bucket_flow_fixture()
      assert Buckets.get_bucket_flow!(bucket_flow.id) == bucket_flow
    end

    test "create_bucket_flow/1 with valid data creates a bucket_flow" do
      valid_attrs = %{amount: "120.5", bucket_flow_id: "some bucket_flow_id", bucket_in: "some bucket_in", bucket_out: "some bucket_out", bucket_tx_id: "some bucket_tx_id"}

      assert {:ok, %BucketFlow{} = bucket_flow} = Buckets.create_bucket_flow(valid_attrs)
      assert bucket_flow.amount == Decimal.new("120.5")
      assert bucket_flow.bucket_flow_id == "some bucket_flow_id"
      assert bucket_flow.bucket_in == "some bucket_in"
      assert bucket_flow.bucket_out == "some bucket_out"
      assert bucket_flow.bucket_tx_id == "some bucket_tx_id"
    end

    test "create_bucket_flow/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Buckets.create_bucket_flow(@invalid_attrs)
    end

    test "update_bucket_flow/2 with valid data updates the bucket_flow" do
      bucket_flow = bucket_flow_fixture()
      update_attrs = %{amount: "456.7", bucket_flow_id: "some updated bucket_flow_id", bucket_in: "some updated bucket_in", bucket_out: "some updated bucket_out", bucket_tx_id: "some updated bucket_tx_id"}

      assert {:ok, %BucketFlow{} = bucket_flow} = Buckets.update_bucket_flow(bucket_flow, update_attrs)
      assert bucket_flow.amount == Decimal.new("456.7")
      assert bucket_flow.bucket_flow_id == "some updated bucket_flow_id"
      assert bucket_flow.bucket_in == "some updated bucket_in"
      assert bucket_flow.bucket_out == "some updated bucket_out"
      assert bucket_flow.bucket_tx_id == "some updated bucket_tx_id"
    end

    test "update_bucket_flow/2 with invalid data returns error changeset" do
      bucket_flow = bucket_flow_fixture()
      assert {:error, %Ecto.Changeset{}} = Buckets.update_bucket_flow(bucket_flow, @invalid_attrs)
      assert bucket_flow == Buckets.get_bucket_flow!(bucket_flow.id)
    end

    test "delete_bucket_flow/1 deletes the bucket_flow" do
      bucket_flow = bucket_flow_fixture()
      assert {:ok, %BucketFlow{}} = Buckets.delete_bucket_flow(bucket_flow)
      assert_raise Ecto.NoResultsError, fn -> Buckets.get_bucket_flow!(bucket_flow.id) end
    end

    test "change_bucket_flow/1 returns a bucket_flow changeset" do
      bucket_flow = bucket_flow_fixture()
      assert %Ecto.Changeset{} = Buckets.change_bucket_flow(bucket_flow)
    end




  end
end
