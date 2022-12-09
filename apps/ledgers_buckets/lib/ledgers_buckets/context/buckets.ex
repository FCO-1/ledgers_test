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

  def create_new_bucket_transaccion(attrs) do
    Repo.transaction(fn ->
      with {:ok, bucket_txs} <- build_bucket_txs(attrs) |> create_bucket_txs(),
      {:ok, _bucket_tx_from} <- build_tx_from(attrs) |> create_bucket_tx_from(),
      {:ok, _bucket_tx_to} <- build_tx_to(attrs, bucket_txs) |> create_bucket_tx_to(),
      {:ok, bucket_grm} <- build_bucket(attrs, bucket_txs) |> create_bucket(),
      {:ok, _bucket_flow} <- build_bucket_flow(attrs, bucket_txs, bucket_grm.bucket_id, nil) |> create_bucket_flow() do
        bucket_txs
      else
        {:error, changeset} ->
          changeset
          |> Repo.rollback()
      end
    end)
  end



  def create_new_bucket_transaccion_for_swap(attrs, list_ids) do

    Repo.transaction(fn ->
      with {:ok, bucket_txs} <- build_bucket_txs(attrs) |> create_bucket_txs(),
      {:ok, _bucket_tx_from} <- build_tx_from(attrs) |> create_bucket_tx_from(),
      {:ok, _bucket_tx_to} <- build_tx_to(attrs, bucket_txs) |> create_bucket_tx_to(),
      {:ok, _bucketsdeleted} <- delete_many_buckets(list_ids),
      {:ok, _created_new_bucket} <- build_bucket(attrs, bucket_txs) |> create_bucket() do
        bucket_txs
      else
        {:error, changeset} ->
          changeset
          |> Repo.rollback()
      end
    end)
  end

  def create_new_bucket_transaccion_for_new_buckets(attrs, amount, remain, list_ids) do
    map = Map.merge(attrs, %{"amount" => amount})
    map_remain = Map.merge(attrs, %{"is_spent" => 0, "locket_4_tx" => 0, "amount" => remain})
    Repo.transaction(fn ->
      with {:ok, bucket_txs} <- build_bucket_txs(map) |> create_bucket_txs(),
      {:ok, _bucket_tx_from} <- build_tx_from(map) |> create_bucket_tx_from(),
      {:ok, _bucket_tx_to} <- build_tx_to(map, bucket_txs) |> create_bucket_tx_to(),
      {:ok, _bucketsdeleted} <- delete_many_buckets(list_ids),
      {:ok, _created_new_bucket} <- build_bucket(map, bucket_txs) |> create_bucket(),
      {:ok, _created_new_bucket} <- build_bucket(map_remain, bucket_txs) |> create_bucket() do
        bucket_txs
      else
        {:error, changeset} ->
          changeset
          |> Repo.rollback()
      end
    end)
  end

  def test_new_bucket_swap do
    map = %{
      "amount" => "",
      "asset" => "MXN",
      "bucket_tx_at" => "2022-12-06T21:43",
      "note" => "cliente cliente",
      "owner_from" => "cliente25",
      "owner_to" => "cliente25",
      "reference_id" => "Or221",
      "reference_type" => "order",
      "request_id" => "1224123",
      "state" => "pending",
      "status" => "open",
      "type" => "swap",
      "wallet_from" => "cmd.mint",
      "wallet_to" => "irl.efectivo"
    }

    create_new_bucket_transaccion_for_swap(map, ["bucket_1000", "bucket_1001"])

  end


  def build_bucket_txs(params) do
    map = %{
      amount: params["amount"],
      asset: params["asset"],
      bucket_tx_at: params["bucket_tx_at"],
      bucket_tx_id: generate_bucket_tx_serial(),
      note: params["note"],
      reference_id: params["reference_id"],
      reference_type: "order",
      request_id: "1122321",
      state: params["state"],
      status: params["status"],
      type: params["type"],
    }
    generate_hash(map)
  end

  def generate_hash(map) do
    chain = Jason.encode!(map) |> to_string()
    hash_brute = :crypto.hash(:sha256, chain)
    IO.inspect(hash_brute)
#
   Map.merge(map, %{hash: "#{hash_brute}"})
  end

  def build_tx_from(params) do
    %{
      amount: params["amount"],
      asset: params["asset"],
      bucket_tx_from_id: generate_bucket_tx_from_serial(),
      owner: params["owner_from"],
      type: "fix",
      wallet: params["wallet_from"] || nil,
      weight: 0
    }
  end

  def build_tx_to(params, tx) do
    %{
      amount: params["amount"],
      assets: params["asset"],
      bucket_tx_id: tx.id,
      onwer: params["owner_to"],
      wallet: params["wallet_to"]
    }
  end

  def build_bucket(params, tx) do
    %{
      amount: params["amount"],
      asset: params["asset"],
      asset_reference: "??",
      asset_type: params["type"],
      bucket_at: NaiveDateTime.local_now(),
      bucket_id: generate_bucket_serial(),
      bucket_tx_id: tx.id ,
      is_spent: params["is_spent"],
      lock_4_tx: params["locket_4_tx"],
      locked_at: NaiveDateTime.local_now(),
      locked_by_tx_id: tx.id,
      owner: params["owner_to"],
      spent_at: NaiveDateTime.local_now(),
      type: params["type"],
      wallet: params["wallet_to"]
    }
  end

  def build_bucket_flow(params, bucket_tx, bucket_out, bucket_in \\ nil ) do
    %{
      amount: params["amount"],
      bucket_flow_id: generate_bucket_flow_serial(),
      bucket_in: bucket_in,
      bucket_out: bucket_out,
      bucket_tx_id: bucket_tx.bucket_tx_id,
    }
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


  def list_buckets_by_list_ids(list_bucket_ids) do
    query = from bct in Bucket,
    where: bct.bucket_id in ^list_bucket_ids,
    where: bct.is_spent == 0


    Repo.all(query)
  end

  def get_sum_buckets_by_list_ids(list_bucket_ids) do
    query = from bct in Bucket,
    where: bct.bucket_id in ^list_bucket_ids,
    where: bct.is_spent == 0,
    group_by: bct.owner,
    select: sum(bct.amount)

    Repo.one(query)
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


  def search_and_get_free_buckets(bucket_tx_id) do
    query =  from b in Bucket,
    where: b.is_spent == 0 and b.lock_4_tx == 0 and b.bucket_tx_id == ^bucket_tx_id
    Repo.all(query)
  end

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

  def delete_many_buckets(list_buckets_ids) do
    query = from bct in Bucket,
    where: bct.bucket_id in ^list_buckets_ids

    Ecto.Multi.new()
    |> Ecto.Multi.delete_all(:buckets, query)
    |> Repo.transaction()
    |> case do
      {:ok, %{buckets: bucket}} -> {:ok, bucket}
      {:error, :buckets, changeset, _} -> {:error, changeset}
    end
  end

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

  alias LedgersBuckets.Buckets.BucketFlow

  @doc """
  Returns the list of bucket_flows.

  ## Examples

      iex> list_bucket_flows()
      [%BucketFlow{}, ...]

  """
  def list_bucket_flows do
    Repo.all(BucketFlow)
  end

  @doc """
  Gets a single bucket_flow.

  Raises `Ecto.NoResultsError` if the Bucket flow does not exist.

  ## Examples

      iex> get_bucket_flow!(123)
      %BucketFlow{}

      iex> get_bucket_flow!(456)
      ** (Ecto.NoResultsError)

  """
  def get_bucket_flow!(id), do: Repo.get!(BucketFlow, id)

  @doc """
  Creates a bucket_flow.

  ## Examples

      iex> create_bucket_flow(%{field: value})
      {:ok, %BucketFlow{}}

      iex> create_bucket_flow(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_bucket_flow(attrs \\ %{}) do
    %BucketFlow{}
    |> BucketFlow.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a bucket_flow.

  ## Examples

      iex> update_bucket_flow(bucket_flow, %{field: new_value})
      {:ok, %BucketFlow{}}

      iex> update_bucket_flow(bucket_flow, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_bucket_flow(%BucketFlow{} = bucket_flow, attrs) do
    bucket_flow
    |> BucketFlow.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a bucket_flow.

  ## Examples

      iex> delete_bucket_flow(bucket_flow)
      {:ok, %BucketFlow{}}

      iex> delete_bucket_flow(bucket_flow)
      {:error, %Ecto.Changeset{}}

  """
  def delete_bucket_flow(%BucketFlow{} = bucket_flow) do
    Repo.delete(bucket_flow)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking bucket_flow changes.

  ## Examples

      iex> change_bucket_flow(bucket_flow)
      %Ecto.Changeset{data: %BucketFlow{}}

  """
  def change_bucket_flow(%BucketFlow{} = bucket_flow, attrs \\ %{}) do
    BucketFlow.changeset(bucket_flow, attrs)
  end

  def generate_bucket_tx_serial do
    "bucket_tx_#{get_bucket_txs_secuence()}"
  end

  def generate_bucket_tx_from_serial do
    "bucket_tx_from-#{get_bucket_tx_from_secuence()}"
  end

  def generate_bucket_tx_to_serial do
    "bucket_tx_from_#{get_bucket_tx_to_secuence()}"
  end

  def generate_bucket_serial do
    "bucket_#{get_bucket_secuence()}"
  end

  def generate_bucket_flow_serial do
    "bucket_flow_#{get_bucket_flow_secuence()}"
  end

  def get_bucket_txs_secuence do
    case Ecto.Adapters.SQL.query(Repo, "SELECT NEXTVAL('buckets.bucket_txs_sequence')::citext;", []) do
       {:ok, result} ->
         result.rows |> List.first() |> List.first()

       {:error, _error} ->
         nil
     end
   end

   def get_bucket_tx_from_secuence do
    case Ecto.Adapters.SQL.query(Repo, "SELECT NEXTVAL('buckets.bucket_tx_from_sequence')::citext;", []) do
       {:ok, result} ->
         result.rows |> List.first() |> List.first()

       {:error, _error} ->
         nil
     end
   end

   def get_bucket_tx_to_secuence do
    case Ecto.Adapters.SQL.query(Repo, "SELECT NEXTVAL('buckets.bucket_tx_to_sequence')::citext;", []) do
       {:ok, result} ->
         result.rows |> List.first() |> List.first()

       {:error, _error} ->
         nil
     end
   end

   def get_bucket_secuence do
    case Ecto.Adapters.SQL.query(Repo, "SELECT NEXTVAL('buckets.bucket_sequence')::citext;", []) do
       {:ok, result} ->
         result.rows |> List.first() |> List.first()

       {:error, _error} ->
         nil
     end
   end
   def get_bucket_flow_secuence do
    case Ecto.Adapters.SQL.query(Repo, "SELECT NEXTVAL('buckets.bucket_flow_sequence')::citext;", []) do
       {:ok, result} ->
         result.rows |> List.first() |> List.first()

       {:error, _error} ->
         nil
     end
   end
end