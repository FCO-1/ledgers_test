defmodule LedgersBuckets.AccountBooksTest do
  use LedgersBuckets.DataCase

  alias LedgersBuckets.AccountBooks

  describe "wallets" do
    alias LedgersBuckets.AccountBooks.Wallet

    import LedgersBuckets.AccountBooksFixtures

    @invalid_attrs %{extras: nil, name: nil, node: nil, path: nil, state: nil, weigh: nil, weight: nil}

    test "list_wallets/0 returns all wallets" do
      wallet = wallet_fixture()
      assert AccountBooks.list_wallets() == [wallet]
    end

    test "get_wallet!/1 returns the wallet with given id" do
      wallet = wallet_fixture()
      assert AccountBooks.get_wallet!(wallet.id) == wallet
    end

    test "create_wallet/1 with valid data creates a wallet" do
      valid_attrs = %{extras: %{}, name: "some name", node: "some node", path: "some path", state: "some state", weigh: "some weigh", weight: 42}

      assert {:ok, %Wallet{} = wallet} = AccountBooks.create_wallet(valid_attrs)
      assert wallet.extras == %{}
      assert wallet.name == "some name"
      assert wallet.node == "some node"
      assert wallet.path == "some path"
      assert wallet.state == "some state"
      assert wallet.weight == 42
    end

    test "create_wallet/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = AccountBooks.create_wallet(@invalid_attrs)
    end

    test "update_wallet/2 with valid data updates the wallet" do
      wallet = wallet_fixture()
      update_attrs = %{extras: %{}, name: "some updated name", node: "some updated node", path: "some updated path", state: "some updated state", weigh: "some updated weigh", weight: 43}

      assert {:ok, %Wallet{} = wallet} = AccountBooks.update_wallet(wallet, update_attrs)
      assert wallet.extras == %{}
      assert wallet.name == "some updated name"
      assert wallet.node == "some updated node"
      assert wallet.path == "some updated path"
      assert wallet.state == "some updated state"
      assert wallet.weight == 43
    end

    test "update_wallet/2 with invalid data returns error changeset" do
      wallet = wallet_fixture()
      assert {:error, %Ecto.Changeset{}} = AccountBooks.update_wallet(wallet, @invalid_attrs)
      assert wallet == AccountBooks.get_wallet!(wallet.id)
    end

    test "delete_wallet/1 deletes the wallet" do
      wallet = wallet_fixture()
      assert {:ok, %Wallet{}} = AccountBooks.delete_wallet(wallet)
      assert_raise Ecto.NoResultsError, fn -> AccountBooks.get_wallet!(wallet.id) end
    end

    test "change_wallet/1 returns a wallet changeset" do
      wallet = wallet_fixture()
      assert %Ecto.Changeset{} = AccountBooks.change_wallet(wallet)
    end
  end
end
