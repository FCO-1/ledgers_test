defmodule Core.TransactionsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Core.Transactions` context.
  """

  @doc """
  Generate a utxio.
  """
  def utxio_fixture(attrs \\ %{}) do
    {:ok, utxio} =
      attrs
      |> Enum.into(%{
        assetmedio: "some assetmedio",
        object_id: "some object_id",
        size: "120.5",
        tx_reference_id: "some tx_reference_id"
      })
      |> Core.Transactions.create_utxio()

    utxio
  end
end
