defmodule LedgersBuckets.AccountBooksFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `LedgersBuckets.AccountBooks` context.
  """

  @doc """
  Generate a wallet.
  """
  def wallet_fixture(attrs \\ %{}) do
    {:ok, wallet} =
      attrs
      |> Enum.into(%{
        extras: %{},
        name: "some name",
        node: "some node",
        path: "some path",
        state: "some state",
        weight: 42
      })
      |> LedgersBuckets.AccountBooks.create_wallet()

    wallet
  end
end
