defmodule Core.BucketsTest do
  use Core.DataCase

  alias Core.Buckets

  describe "bucket_table" do
    alias Core.Buckets.BucketTable

    import Core.BucketsFixtures

    @invalid_attrs %{ammount: nil, asset: nil, bucket_id: nil, hash: nil, locked_by: nil, owner: nil, state_locked: nil, state_spent: nil}

    test "list_bucket_table/0 returns all bucket_table" do
      bucket_table = bucket_table_fixture()
      assert Buckets.list_bucket_table() == [bucket_table]
    end

    test "get_bucket_table!/1 returns the bucket_table with given id" do
      bucket_table = bucket_table_fixture()
      assert Buckets.get_bucket_table!(bucket_table.id) == bucket_table
    end

    test "create_bucket_table/1 with valid data creates a bucket_table" do
      valid_attrs = %{ammount: "some ammount", asset: "some asset", bucket_id: "some bucket_id", hash: "some hash", locked_by: "some locked_by", owner: "some owner", state_locked: "some state_locked", state_spent: "some state_spent"}

      assert {:ok, %BucketTable{} = bucket_table} = Buckets.create_bucket_table(valid_attrs)
      assert bucket_table.ammount == "some ammount"
      assert bucket_table.asset == "some asset"
      assert bucket_table.bucket_id == "some bucket_id"
      assert bucket_table.hash == "some hash"
      assert bucket_table.locked_by == "some locked_by"
      assert bucket_table.owner == "some owner"
      assert bucket_table.state_locked == "some state_locked"
      assert bucket_table.state_spent == "some state_spent"
    end

    test "create_bucket_table/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Buckets.create_bucket_table(@invalid_attrs)
    end

    test "update_bucket_table/2 with valid data updates the bucket_table" do
      bucket_table = bucket_table_fixture()
      update_attrs = %{ammount: "some updated ammount", asset: "some updated asset", bucket_id: "some updated bucket_id", hash: "some updated hash", locked_by: "some updated locked_by", owner: "some updated owner", state_locked: "some updated state_locked", state_spent: "some updated state_spent"}

      assert {:ok, %BucketTable{} = bucket_table} = Buckets.update_bucket_table(bucket_table, update_attrs)
      assert bucket_table.ammount == "some updated ammount"
      assert bucket_table.asset == "some updated asset"
      assert bucket_table.bucket_id == "some updated bucket_id"
      assert bucket_table.hash == "some updated hash"
      assert bucket_table.locked_by == "some updated locked_by"
      assert bucket_table.owner == "some updated owner"
      assert bucket_table.state_locked == "some updated state_locked"
      assert bucket_table.state_spent == "some updated state_spent"
    end

    test "update_bucket_table/2 with invalid data returns error changeset" do
      bucket_table = bucket_table_fixture()
      assert {:error, %Ecto.Changeset{}} = Buckets.update_bucket_table(bucket_table, @invalid_attrs)
      assert bucket_table == Buckets.get_bucket_table!(bucket_table.id)
    end

    test "delete_bucket_table/1 deletes the bucket_table" do
      bucket_table = bucket_table_fixture()
      assert {:ok, %BucketTable{}} = Buckets.delete_bucket_table(bucket_table)
      assert_raise Ecto.NoResultsError, fn -> Buckets.get_bucket_table!(bucket_table.id) end
    end

    test "change_bucket_table/1 returns a bucket_table changeset" do
      bucket_table = bucket_table_fixture()
      assert %Ecto.Changeset{} = Buckets.change_bucket_table(bucket_table)
    end
  end
end
