defmodule LedgersBuckets.Buckets do
  @moduledoc """
  The Buckets context.
  """

  import Ecto.Query, warn: false
  alias LedgersBuckets.Repo

  alias LedgersBuckets.Buckets.BucketTxs

  @doc """
  Returns the list of bucket_txs.

  ## Examples

      iex> list_bucket_txs()
      [%BucketTxs{}, ...]

  """
  def list_bucket_txs do
    Repo.all(BucketTxs)
  end

  @doc """
  Gets a single bucket_txs.

  Raises `Ecto.NoResultsError` if the Bucket txs does not exist.

  ## Examples

      iex> get_bucket_txs!(123)
      %BucketTxs{}

      iex> get_bucket_txs!(456)
      ** (Ecto.NoResultsError)

  """
  def get_bucket_txs!(id), do: Repo.get!(BucketTxs, id)

  @doc """
  Creates a bucket_txs.

  ## Examples

      iex> create_bucket_txs(%{field: value})
      {:ok, %BucketTxs{}}

      iex> create_bucket_txs(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_bucket_txs(attrs \\ %{}) do
    %BucketTxs{}
    |> BucketTxs.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a bucket_txs.

  ## Examples

      iex> update_bucket_txs(bucket_txs, %{field: new_value})
      {:ok, %BucketTxs{}}

      iex> update_bucket_txs(bucket_txs, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_bucket_txs(%BucketTxs{} = bucket_txs, attrs) do
    bucket_txs
    |> BucketTxs.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a bucket_txs.

  ## Examples

      iex> delete_bucket_txs(bucket_txs)
      {:ok, %BucketTxs{}}

      iex> delete_bucket_txs(bucket_txs)
      {:error, %Ecto.Changeset{}}

  """
  def delete_bucket_txs(%BucketTxs{} = bucket_txs) do
    Repo.delete(bucket_txs)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking bucket_txs changes.

  ## Examples

      iex> change_bucket_txs(bucket_txs)
      %Ecto.Changeset{data: %BucketTxs{}}

  """
  def change_bucket_txs(%BucketTxs{} = bucket_txs, attrs \\ %{}) do
    BucketTxs.changeset(bucket_txs, attrs)
  end
end
