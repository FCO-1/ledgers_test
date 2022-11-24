defmodule Core.TransactionsTest do
  use Core.DataCase

  alias Core.Transactions

  describe "utxio" do
    alias Core.Transactions.Utxio

    import Core.TransactionsFixtures

    @invalid_attrs %{assetmedio: nil, object_id: nil, size: nil, tx_reference_id: nil}

    test "list_utxio/0 returns all utxio" do
      utxio = utxio_fixture()
      assert Transactions.list_utxio() == [utxio]
    end

    test "get_utxio!/1 returns the utxio with given id" do
      utxio = utxio_fixture()
      assert Transactions.get_utxio!(utxio.id) == utxio
    end

    test "create_utxio/1 with valid data creates a utxio" do
      valid_attrs = %{assetmedio: "some assetmedio", object_id: "some object_id", size: "120.5", tx_reference_id: "some tx_reference_id"}

      assert {:ok, %Utxio{} = utxio} = Transactions.create_utxio(valid_attrs)
      assert utxio.assetmedio == "some assetmedio"
      assert utxio.object_id == "some object_id"
      assert utxio.size == Decimal.new("120.5")
      assert utxio.tx_reference_id == "some tx_reference_id"
    end

    test "create_utxio/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Transactions.create_utxio(@invalid_attrs)
    end

    test "update_utxio/2 with valid data updates the utxio" do
      utxio = utxio_fixture()
      update_attrs = %{assetmedio: "some updated assetmedio", object_id: "some updated object_id", size: "456.7", tx_reference_id: "some updated tx_reference_id"}

      assert {:ok, %Utxio{} = utxio} = Transactions.update_utxio(utxio, update_attrs)
      assert utxio.assetmedio == "some updated assetmedio"
      assert utxio.object_id == "some updated object_id"
      assert utxio.size == Decimal.new("456.7")
      assert utxio.tx_reference_id == "some updated tx_reference_id"
    end

    test "update_utxio/2 with invalid data returns error changeset" do
      utxio = utxio_fixture()
      assert {:error, %Ecto.Changeset{}} = Transactions.update_utxio(utxio, @invalid_attrs)
      assert utxio == Transactions.get_utxio!(utxio.id)
    end

    test "delete_utxio/1 deletes the utxio" do
      utxio = utxio_fixture()
      assert {:ok, %Utxio{}} = Transactions.delete_utxio(utxio)
      assert_raise Ecto.NoResultsError, fn -> Transactions.get_utxio!(utxio.id) end
    end

    test "change_utxio/1 returns a utxio changeset" do
      utxio = utxio_fixture()
      assert %Ecto.Changeset{} = Transactions.change_utxio(utxio)
    end
  end
end
