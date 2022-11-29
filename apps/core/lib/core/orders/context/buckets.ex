defmodule Core.Buckets do
  @moduledoc """
  The Buckets context.
  """

  import Ecto.Query, warn: false
  alias String.Chars.Decimal
  alias Core.Repo

  alias Core.Buckets.BucketTable

  @doc """
  Returns the list of bucket_table.

  ## Examples

      iex> list_bucket_table()
      [%BucketTable{}, ...]

  """
  def list_bucket_table do
    Repo.all(BucketTable)
  end

  @doc """
  Gets a single bucket_table.

  Raises `Ecto.NoResultsError` if the Bucket table does not exist.

  ## Examples

      iex> get_bucket_table!(123)
      %BucketTable{}

      iex> get_bucket_table!(456)
      ** (Ecto.NoResultsError)

  """
  def get_bucket_table!(id), do: Repo.get!(BucketTable, id)

  @doc """
  Creates a bucket_table.

  ## Examples

      iex> create_bucket_table(%{field: value})
      {:ok, %BucketTable{}}

      iex> create_bucket_table(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_new_repo_acta(attrs, tx_1) do
    result = Repo.transaction(fn ->
      with {:ok, buckekt} <- build_bucket_table(attrs, tx_1) |> create_bucket_table() do
        buckekt
      end
    end)

    {:ok, result}
  end

  def build_bucket_table(params, tx_1) do

    serial = get_bucket_serial()
    map = %{
      ammount: tx_1.ammount,
      asset: params["assetmedio"],
      bucket_id: serial,
      locked_by: tx_1.tx_table,
      owner: params["owner"],
      state_locked: "1",
      state_spent: "0",
    }

    Map.merge(map, %{hash: generate_hash(map)})
  end

  def get_bucket_serial do
    number = get_bucket_sequence()
    "bucket_#{number}"
  end

  def generate_hash(map) do
    Jason.encode!(map) |> to_string() |> Base.encode64()
  end

  def get_bucket_sequence do
    case Ecto.Adapters.SQL.query(Repo, "SELECT NEXTVAL('transactions.bucket_sequence')::citext;", []) do
       {:ok, result} ->
         result.rows |> List.first() |> List.first()

       {:error, _error} ->
         nil
     end
   end

  def create_bucket_table(attrs \\ %{}) do
    %BucketTable{}
    |> BucketTable.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a bucket_table.

  ## Examples

      iex> update_bucket_table(bucket_table, %{field: new_value})
      {:ok, %BucketTable{}}

      iex> update_bucket_table(bucket_table, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_bucket_table(%BucketTable{} = bucket_table, attrs) do
    bucket_table
    |> BucketTable.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a bucket_table.

  ## Examples

      iex> delete_bucket_table(bucket_table)
      {:ok, %BucketTable{}}

      iex> delete_bucket_table(bucket_table)
      {:error, %Ecto.Changeset{}}

  """
  def delete_bucket_table(%BucketTable{} = bucket_table) do
    Repo.delete(bucket_table)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking bucket_table changes.

  ## Examples

      iex> change_bucket_table(bucket_table)
      %Ecto.Changeset{data: %BucketTable{}}

  """
  def change_bucket_table(%BucketTable{} = bucket_table, attrs \\ %{}) do
    BucketTable.changeset(bucket_table, attrs)
  end
end
