defmodule LedgersBuckets.Api.BucketsApi do
  alias LedgersBuckets.Domain.BucketsDomain

    @moduledoc """
    The BucketsDomain context.
    """



    @doc """
    Returns the list of bucket_txs.

    ## Examples

        iex> list_bucket_txs()
        [%BucketTxs{}, ...]

    """
    def list_bucket_txs do
      BucketsDomain.list_bucket_txs()
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
    def get_bucket_txs!(id), do: BucketsDomain.get_bucket_txs!(id)

    @doc """
    Creates a bucket_txs.

    ## Examples

        iex> create_bucket_txs(%{field: value})
        {:ok, %BucketTxs{}}

        iex> create_bucket_txs(%{field: bad_value})
        {:error, %Ecto.Changeset{}}

    """
    def create_bucket_txs(attrs) do
      BucketsDomain.create_bucket_txs(attrs)
    end

    def create_new_bucket_transaccion(attrs) do
      BucketsDomain.create_new_bucket_transaccion(Map.merge(attrs, %{"is_spent" => 0, "locket_4_tx" => 0}))
    end

    def create_new_buckets_for_swap(attrs, list_buckets_ids) do
      BucketsDomain.create_new_buckets_for_swap(attrs, list_buckets_ids)
    end

    def create_new_buckets_for_partitions(attrs, amount, list_buckets_ids) do
      BucketsDomain.create_new_buckets_for_partitions(attrs, amount, list_buckets_ids)
    end


    def generate_hash(map) do
     BucketsDomain.generate_hash(map)
    end


    @doc """
    Updates a bucket_txs.

    ## Examples

        iex> update_bucket_txs(bucket_txs, %{field: new_value})
        {:ok, %BucketTxs{}}

        iex> update_bucket_txs(bucket_txs, %{field: bad_value})
        {:error, %Ecto.Changeset{}}

    """
    def update_bucket_txs(bucket_txs, attrs) do
      BucketsDomain.update_bucket_txs(bucket_txs, attrs)
    end

    @doc """
    Deletes a bucket_txs.

    ## Examples

        iex> delete_bucket_txs(bucket_txs)
        {:ok, %BucketTxs{}}

        iex> delete_bucket_txs(bucket_txs)
        {:error, %Ecto.Changeset{}}

    """
    def delete_bucket_txs(bucket_txs) do
      BucketsDomain.delete_bucket_txs(bucket_txs)
    end

    @doc """
    Returns an `%Ecto.Changeset{}` for tracking bucket_txs changes.

    ## Examples

        iex> change_bucket_txs(bucket_txs)
        %Ecto.Changeset{data: %BucketTxs{}}

    """
    def change_bucket_txs(bucket_txs) do
      BucketsDomain.change_bucket_txs(bucket_txs)
    end
    def change_bucket_txs(bucket_txs, attrs) do
      BucketsDomain.change_bucket_txs(bucket_txs, attrs)
    end
    ########################################
    # LedgersBuckets.BucketsDomain.BucketTxFrom
    ########################################

    @doc """
    Returns the list of bucket_tx_from.

    ## Examples

        iex> list_bucket_tx_from()
        [%BucketTxFrom{}, ...]

    """
    def list_bucket_tx_from do
      BucketsDomain.list_bucket_tx_from()
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
    def get_bucket_tx_from!(id), do: BucketsDomain.get_bucket_tx_from!(id)

    @doc """
    Creates a bucket_tx_from.

    ## Examples

        iex> create_bucket_tx_from(%{field: value})
        {:ok, %BucketTxFrom{}}

        iex> create_bucket_tx_from(%{field: bad_value})
        {:error, %Ecto.Changeset{}}

    """
    def create_bucket_tx_from(attrs) do
      BucketsDomain.create_bucket_tx_from(attrs)
    end
    @doc """
    Updates a bucket_tx_from.

    ## Examples

        iex> update_bucket_tx_from(bucket_tx_from, %{field: new_value})
        {:ok, %BucketTxFrom{}}

        iex> update_bucket_tx_from(bucket_tx_from, %{field: bad_value})
        {:error, %Ecto.Changeset{}}

    """
    def update_bucket_tx_from(bucket_tx_from, attrs) do
      BucketsDomain.update_bucket_tx_from(bucket_tx_from, attrs)
    end

    @doc """
    Deletes a bucket_tx_from.

    ## Examples

        iex> delete_bucket_tx_from(bucket_tx_from)
        {:ok, %BucketTxFrom{}}

        iex> delete_bucket_tx_from(bucket_tx_from)
        {:error, %Ecto.Changeset{}}

    """
    def delete_bucket_tx_from(bucket_tx_from) do
      BucketsDomain.delete_bucket_tx_from(bucket_tx_from)
    end

    @doc """
    Returns an `%Ecto.Changeset{}` for tracking bucket_tx_from changes.

    ## Examples

        iex> change_bucket_tx_from(bucket_tx_from)
        %Ecto.Changeset{data: %BucketTxFrom{}}

    """
    def change_bucket_tx_from(bucket_tx_from) do
      BucketsDomain.change_bucket_tx_from(bucket_tx_from)
    end

    def change_bucket_tx_from(bucket_tx_from, attrs) do
      BucketsDomain.change_bucket_tx_from(bucket_tx_from, attrs)
    end
    #####################################
    #LedgersBuckets.BucketsDomain.BucketTxTo
    #####################################
    @doc """
    Returns the list of bucket_tx_to.

    ## Examples

        iex> list_bucket_tx_to()
        [%BucketTxTo{}, ...]

    """
    def list_bucket_tx_to do
      BucketsDomain.list_bucket_tx_to()
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
    def get_bucket_tx_to!(id), do: BucketsDomain.get_bucket_tx_to!(id)

    @doc """
    Creates a bucket_tx_to.

    ## Examples

        iex> create_bucket_tx_to(%{field: value})
        {:ok, %BucketTxTo{}}

        iex> create_bucket_tx_to(%{field: bad_value})
        {:error, %Ecto.Changeset{}}

    """
    def create_bucket_tx_to(attrs) do
      BucketsDomain.create_bucket_tx_to(attrs)
    end

    @doc """
    Updates a bucket_tx_to.

    ## Examples

        iex> update_bucket_tx_to(bucket_tx_to, %{field: new_value})
        {:ok, %BucketTxTo{}}

        iex> update_bucket_tx_to(bucket_tx_to, %{field: bad_value})
        {:error, %Ecto.Changeset{}}

    """
    def update_bucket_tx_to(bucket_tx_to, attrs) do
      BucketsDomain.update_bucket_tx_to(bucket_tx_to, attrs)
    end

    @doc """
    Deletes a bucket_tx_to.

    ## Examples

        iex> delete_bucket_tx_to(bucket_tx_to)
        {:ok, %BucketTxTo{}}

        iex> delete_bucket_tx_to(bucket_tx_to)
        {:error, %Ecto.Changeset{}}

    """
    def delete_bucket_tx_to(bucket_tx_to) do
      BucketsDomain.delete_bucket_tx_to(bucket_tx_to)
    end

    @doc """
    Returns an `%Ecto.Changeset{}` for tracking bucket_tx_to changes.

    ## Examples

        iex> change_bucket_tx_to(bucket_tx_to)
        %Ecto.Changeset{data: %BucketTxTo{}}

    """
    def change_bucket_tx_to(bucket_tx_to) do
      BucketsDomain.change_bucket_tx_to(bucket_tx_to)
    end

    def change_bucket_tx_to(bucket_tx_to, attrs) do
      BucketsDomain.change_bucket_tx_to(bucket_tx_to, attrs)
    end
    ###########################################################
    #alias LedgersBuckets.BucketsDomain.Bucket
    ###########################################################
    @doc """
    Returns the list of buckets.

    ## Examples

        iex> list_buckets()
        [%Bucket{}, ...]

    """
    def list_buckets do
      BucketsDomain.list_buckets()
    end


    def list_buckets_by_list_ids(list_bucket_ids) do
      BucketsDomain.list_buckets_by_list_ids(list_bucket_ids)
    end

    def get_sum_buckets_by_list_ids(list_bucket_ids) do
     BucketsDomain.get_sum_buckets_by_list_ids(list_bucket_ids)
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
    def get_bucket!(id), do: BucketsDomain.get_bucket!(id)


    def search_and_get_free_buckets(bucket_tx_id) do
      BucketsDomain.search_and_get_free_buckets(bucket_tx_id)
    end

    @doc """
    Creates a bucket.

    ## Examples

        iex> create_bucket(%{field: value})
        {:ok, %Bucket{}}

        iex> create_bucket(%{field: bad_value})
        {:error, %Ecto.Changeset{}}

    """
    def create_bucket(attrs) do
      BucketsDomain.create_bucket(attrs)
    end


    @doc """
    Updates a bucket.

    ## Examples

        iex> update_bucket(bucket, %{field: new_value})
        {:ok, %Bucket{}}

        iex> update_bucket(bucket, %{field: bad_value})
        {:error, %Ecto.Changeset{}}

    """
    def update_bucket(bucket, attrs) do
      BucketsDomain.update_bucket(bucket, attrs)
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
      BucketsDomain.delete_many_buckets(list_buckets_ids)
    end

    def delete_bucket(bucket) do
      BucketsDomain.delete_bucket(bucket)
    end

    @doc """
    Returns an `%Ecto.Changeset{}` for tracking bucket changes.

    ## Examples

        iex> change_bucket(bucket)
        %Ecto.Changeset{data: %Bucket{}}

    """
    def change_bucket(bucket) do
      BucketsDomain.change_bucket(bucket)
    end
    def change_bucket(bucket, attrs) do
      BucketsDomain.change_bucket(bucket, attrs)
    end

    ##############################################
    #LedgersBuckets.BucketsDomain.BucketFlow
    ##############################################

    @doc """
    Returns the list of bucket_flows.

    ## Examples

        iex> list_bucket_flows()
        [%BucketFlow{}, ...]

    """
    def list_bucket_flows do
      BucketsDomain.list_bucket_flows()
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
    def get_bucket_flow!(id), do: BucketsDomain.get_bucket_flow!(id)

    @doc """
    Creates a bucket_flow.

    ## Examples

        iex> create_bucket_flow(%{field: value})
        {:ok, %BucketFlow{}}

        iex> create_bucket_flow(%{field: bad_value})
        {:error, %Ecto.Changeset{}}

    """
    def create_bucket_flow(attrs) do
      BucketsDomain.create_bucket_flow(attrs)
    end

    @doc """
    Updates a bucket_flow.

    ## Examples

        iex> update_bucket_flow(bucket_flow, %{field: new_value})
        {:ok, %BucketFlow{}}

        iex> update_bucket_flow(bucket_flow, %{field: bad_value})
        {:error, %Ecto.Changeset{}}

    """
    def update_bucket_flow(bucket_flow, attrs) do
      BucketsDomain.update_bucket_flow(bucket_flow, attrs)
    end

    @doc """
    Deletes a bucket_flow.

    ## Examples

        iex> delete_bucket_flow(bucket_flow)
        {:ok, %BucketFlow{}}

        iex> delete_bucket_flow(bucket_flow)
        {:error, %Ecto.Changeset{}}

    """
    def delete_bucket_flow(bucket_flow) do
      BucketsDomain.delete_bucket_flow(bucket_flow)
    end

    @doc """
    Returns an `%Ecto.Changeset{}` for tracking bucket_flow changes.

    ## Examples

        iex> change_bucket_flow(bucket_flow)
        %Ecto.Changeset{data: %BucketFlow{}}

    """
    def change_bucket_flow(bucket_flow) do
      BucketsDomain.change_bucket_flow(bucket_flow)
    end

    def change_bucket_flow(bucket_flow, attrs) do
      BucketsDomain.change_bucket_flow(bucket_flow, attrs)
    end
end
