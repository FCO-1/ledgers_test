defmodule Core.TransactionsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Core.Transactions` context.
  """

  @doc """
  Generate a tx_test.
  """
  def tx_test_fixture(attrs \\ %{}) do
    {:ok, tx_test} =
      attrs
      |> Enum.into(%{
        ammount: "some ammount",
        owner: "some owner",
        reference: "some reference",
        tx_table: "some tx_table",
        way: "some way"
      })
      |> Core.Transactions.create_tx_test()

    tx_test
  end
end
