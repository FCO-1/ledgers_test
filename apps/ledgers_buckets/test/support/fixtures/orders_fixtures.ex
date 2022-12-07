defmodule LedgersBuckets.OrdersFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `LedgersBuckets.Orders` context.
  """

  @doc """
  Generate a order.
  """
  def order_fixture(attrs \\ %{}) do
    {:ok, order} =
      attrs
      |> Enum.into(%{
        amount: "some amount",
        destination: "some destination",
        extras: %{},
        origin: "some origin",
        owner: "some owner",
        state: "some state",
        status: "some status",
        type: "some type"
      })
      |> LedgersBuckets.Orders.create_order()

    order
  end
end
