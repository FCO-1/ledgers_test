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

  alias LedgersBuckets.Buckets.BucketTxFrom

  @doc """
  Returns the list of bucket_tx_from.

  ## Examples

      iex> list_bucket_tx_from()
      [%BucketTxFrom{}, ...]

  """
  def list_bucket_tx_from do
    Repo.all(BucketTxFrom)
  end

  @doc """
  Gets a single bucket_tx_from.

  Raises `Ecto.NoResultsError` if the Bucket tx from does not exist.

  ## Examples

      iex> get_bucket_tx_from!(123)
      %BucketTxFrom{}

      iex> get_bucket_tx_from!(456)
      ** (Ecto.NoResultsError)

  """
  def get_bucket_tx_from!(id), do: Repo.get!(BucketTxFrom, id)

  @doc """
  Creates a bucket_tx_from.

  ## Examples

      iex> create_bucket_tx_from(%{field: value})
      {:ok, %BucketTxFrom{}}

      iex> create_bucket_tx_from(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_bucket_tx_from(attrs \\ %{}) do
    %BucketTxFrom{}
    |> BucketTxFrom.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a bucket_tx_from.

  ## Examples

      iex> update_bucket_tx_from(bucket_tx_from, %{field: new_value})
      {:ok, %BucketTxFrom{}}

      iex> update_bucket_tx_from(bucket_tx_from, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_bucket_tx_from(%BucketTxFrom{} = bucket_tx_from, attrs) do
    bucket_tx_from
    |> BucketTxFrom.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a bucket_tx_from.

  ## Examples

      iex> delete_bucket_tx_from(bucket_tx_from)
      {:ok, %BucketTxFrom{}}

      iex> delete_bucket_tx_from(bucket_tx_from)
      {:error, %Ecto.Changeset{}}

  """
  def delete_bucket_tx_from(%BucketTxFrom{} = bucket_tx_from) do
    Repo.delete(bucket_tx_from)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking bucket_tx_from changes.

  ## Examples

      iex> change_bucket_tx_from(bucket_tx_from)
      %Ecto.Changeset{data: %BucketTxFrom{}}

  """
  def change_bucket_tx_from(%BucketTxFrom{} = bucket_tx_from, attrs \\ %{}) do
    BucketTxFrom.changeset(bucket_tx_from, attrs)
  end

  alias LedgersBuckets.Buckets.BucketTxTo

  @doc """
  Returns the list of bucket_tx_to.

  ## Examples

      iex> list_bucket_tx_to()
      [%BucketTxTo{}, ...]

  """
  def list_bucket_tx_to do
    Repo.all(BucketTxTo)
  end

  @doc """
  Gets a single bucket_tx_to.

  Raises `Ecto.NoResultsError` if the Bucket tx to does not exist.

  ## Examples

      iex> get_bucket_tx_to!(123)
      %BucketTxTo{}

      iex> get_bucket_tx_to!(456)
      ** (Ecto.NoResultsError)

  """
  def get_bucket_tx_to!(id), do: Repo.get!(BucketTxTo, id)

  @doc """
  Creates a bucket_tx_to.

  ## Examples

      iex> create_bucket_tx_to(%{field: value})
      {:ok, %BucketTxTo{}}

      iex> create_bucket_tx_to(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_bucket_tx_to(attrs \\ %{}) do
    %BucketTxTo{}
    |> BucketTxTo.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a bucket_tx_to.

  ## Examples

      iex> update_bucket_tx_to(bucket_tx_to, %{field: new_value})
      {:ok, %BucketTxTo{}}

      iex> update_bucket_tx_to(bucket_tx_to, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_bucket_tx_to(%BucketTxTo{} = bucket_tx_to, attrs) do
    bucket_tx_to
    |> BucketTxTo.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a bucket_tx_to.

  ## Examples

      iex> delete_bucket_tx_to(bucket_tx_to)
      {:ok, %BucketTxTo{}}

      iex> delete_bucket_tx_to(bucket_tx_to)
      {:error, %Ecto.Changeset{}}

  """
  def delete_bucket_tx_to(%BucketTxTo{} = bucket_tx_to) do
    Repo.delete(bucket_tx_to)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking bucket_tx_to changes.

  ## Examples

      iex> change_bucket_tx_to(bucket_tx_to)
      %Ecto.Changeset{data: %BucketTxTo{}}

  """
  def change_bucket_tx_to(%BucketTxTo{} = bucket_tx_to, attrs \\ %{}) do
    BucketTxTo.changeset(bucket_tx_to, attrs)
  end

  alias LedgersBuckets.Buckets.Bucket

  @doc """
  Returns the list of buckets.

  ## Examples

      iex> list_buckets()
      [%Bucket{}, ...]

  """
  def list_buckets do
    Repo.all(Bucket)
  end

  @doc """
  Gets a single bucket.

  Raises `Ecto.NoResultsError` if the Bucket does not exist.

  ## Examples

      iex> get_bucket!(123)
      %Bucket{}

      iex> get_bucket!(456)
      ** (Ecto.NoResultsError)

  """
  def get_bucket!(id), do: Repo.get!(Bucket, id)

  @doc """
  Creates a bucket.

  ## Examples

      iex> create_bucket(%{field: value})
      {:ok, %Bucket{}}

      iex> create_bucket(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_bucket(attrs \\ %{}) do
    %Bucket{}
    |> Bucket.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a bucket.

  ## Examples

      iex> update_bucket(bucket, %{field: new_value})
      {:ok, %Bucket{}}

      iex> update_bucket(bucket, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_bucket(%Bucket{} = bucket, attrs) do
    bucket
    |> Bucket.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a bucket.

  ## Examples

      iex> delete_bucket(bucket)
      {:ok, %Bucket{}}

      iex> delete_bucket(bucket)
      {:error, %Ecto.Changeset{}}

  """
  def delete_bucket(%Bucket{} = bucket) do
    Repo.delete(bucket)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking bucket changes.

  ## Examples

      iex> change_bucket(bucket)
      %Ecto.Changeset{data: %Bucket{}}

  """
  def change_bucket(%Bucket{} = bucket, attrs \\ %{}) do
    Bucket.changeset(bucket, attrs)
  end
end
