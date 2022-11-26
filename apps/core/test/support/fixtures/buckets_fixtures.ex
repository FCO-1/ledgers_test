defmodule Core.BucketsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Core.Buckets` context.
  """

  @doc """
  Generate a bucket_table.
  """
  def bucket_table_fixture(attrs \\ %{}) do
    {:ok, bucket_table} =
      attrs
      |> Enum.into(%{
        ammount: "some ammount",
        asset: "some asset",
        bucket_id: "some bucket_id",
        hash: "some hash",
        locked_by: "some locked_by",
        owner: "some owner",
        state_locked: "some state_locked",
        state_spent: "some state_spent"
      })
      |> Core.Buckets.create_bucket_table()

    bucket_table
  end
end
