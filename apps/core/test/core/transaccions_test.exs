defmodule Core.TransactionsTest do
  use Core.DataCase

  alias Core.Transactions

  describe "tx_tests" do
    alias Core.Transactions.TxTest

    import Core.TransactionsFixtures

    @invalid_attrs %{ammount: nil, owner: nil, reference: nil, tx_table: nil, way: nil}

    test "list_tx_tests/0 returns all tx_tests" do
      tx_test = tx_test_fixture()
      assert Transactions.list_tx_tests() == [tx_test]
    end

    test "get_tx_test!/1 returns the tx_test with given id" do
      tx_test = tx_test_fixture()
      assert Transactions.get_tx_test!(tx_test.id) == tx_test
    end

    test "create_tx_test/1 with valid data creates a tx_test" do
      valid_attrs = %{ammount: "some ammount", owner: "some owner", reference: "some reference", tx_table: "some tx_table", way: "some way"}

      assert {:ok, %TxTest{} = tx_test} = Transactions.create_tx_test(valid_attrs)
      assert tx_test.ammount == "some ammount"
      assert tx_test.owner == "some owner"
      assert tx_test.reference == "some reference"
      assert tx_test.tx_table == "some tx_table"
      assert tx_test.way == "some way"
    end

    test "create_tx_test/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Transactions.create_tx_test(@invalid_attrs)
    end

    test "update_tx_test/2 with valid data updates the tx_test" do
      tx_test = tx_test_fixture()
      update_attrs = %{ammount: "some updated ammount", owner: "some updated owner", reference: "some updated reference", tx_table: "some updated tx_table", way: "some updated way"}

      assert {:ok, %TxTest{} = tx_test} = Transactions.update_tx_test(tx_test, update_attrs)
      assert tx_test.ammount == "some updated ammount"
      assert tx_test.owner == "some updated owner"
      assert tx_test.reference == "some updated reference"
      assert tx_test.tx_table == "some updated tx_table"
      assert tx_test.way == "some updated way"
    end

    test "update_tx_test/2 with invalid data returns error changeset" do
      tx_test = tx_test_fixture()
      assert {:error, %Ecto.Changeset{}} = Transactions.update_tx_test(tx_test, @invalid_attrs)
      assert tx_test == Transactions.get_tx_test!(tx_test.id)
    end

    test "delete_tx_test/1 deletes the tx_test" do
      tx_test = tx_test_fixture()
      assert {:ok, %TxTest{}} = Transactions.delete_tx_test(tx_test)
      assert_raise Ecto.NoResultsError, fn -> Transactions.get_tx_test!(tx_test.id) end
    end

    test "change_tx_test/1 returns a tx_test changeset" do
      tx_test = tx_test_fixture()
      assert %Ecto.Changeset{} = Transactions.change_tx_test(tx_test)
    end
  end
end
