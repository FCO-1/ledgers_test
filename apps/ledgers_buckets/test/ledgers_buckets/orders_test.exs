defmodule LedgersBuckets.OrdersTest do
  use LedgersBuckets.DataCase

  alias LedgersBuckets.Orders

  describe "orders" do
    alias LedgersBuckets.Orders.Order

    import LedgersBuckets.OrdersFixtures

    @invalid_attrs %{amount: nil, destination: nil, extras: nil, origin: nil, owner: nil, state: nil, status: nil, type: nil}

    test "list_orders/0 returns all orders" do
      order = order_fixture()
      assert Orders.list_orders() == [order]
    end

    test "get_order!/1 returns the order with given id" do
      order = order_fixture()
      assert Orders.get_order!(order.id) == order
    end

    test "create_order/1 with valid data creates a order" do
      valid_attrs = %{amount: "some amount", destination: "some destination", extras: %{}, origin: "some origin", owner: "some owner", state: "some state", status: "some status", type: "some type"}

      assert {:ok, %Order{} = order} = Orders.create_order(valid_attrs)
      assert order.amount == "some amount"
      assert order.destination == "some destination"
      assert order.extras == %{}
      assert order.origin == "some origin"
      assert order.owner == "some owner"
      assert order.state == "some state"
      assert order.status == "some status"
      assert order.type == "some type"
    end

    test "create_order/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Orders.create_order(@invalid_attrs)
    end

    test "update_order/2 with valid data updates the order" do
      order = order_fixture()
      update_attrs = %{amount: "some updated amount", destination: "some updated destination", extras: %{}, origin: "some updated origin", owner: "some updated owner", state: "some updated state", status: "some updated status", type: "some updated type"}

      assert {:ok, %Order{} = order} = Orders.update_order(order, update_attrs)
      assert order.amount == "some updated amount"
      assert order.destination == "some updated destination"
      assert order.extras == %{}
      assert order.origin == "some updated origin"
      assert order.owner == "some updated owner"
      assert order.state == "some updated state"
      assert order.status == "some updated status"
      assert order.type == "some updated type"
    end

    test "update_order/2 with invalid data returns error changeset" do
      order = order_fixture()
      assert {:error, %Ecto.Changeset{}} = Orders.update_order(order, @invalid_attrs)
      assert order == Orders.get_order!(order.id)
    end

    test "delete_order/1 deletes the order" do
      order = order_fixture()
      assert {:ok, %Order{}} = Orders.delete_order(order)
      assert_raise Ecto.NoResultsError, fn -> Orders.get_order!(order.id) end
    end

    test "change_order/1 returns a order changeset" do
      order = order_fixture()
      assert %Ecto.Changeset{} = Orders.change_order(order)
    end
  end
end
