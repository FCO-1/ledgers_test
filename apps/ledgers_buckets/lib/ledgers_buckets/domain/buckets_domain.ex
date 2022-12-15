defmodule LedgersBuckets.Domain.BucketsDomain do
  alias LedgersBuckets.Buckets
  alias LedgersBuckets.Schemas.Buckets.BucketForExpand


    @moduledoc """
    The Buckets context.
    """



    @doc """
    Returns the list of bucket_txs.

    ## Examples

        iex> list_bucket_txs()
        [%BucketTxs{}, ...]

    """
    def list_bucket_txs do
      Buckets.list_bucket_txs()
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
    def get_bucket_txs!(id), do: Buckets.get_bucket_txs!(id)

    @doc """
    Creates a bucket_txs.

    ## Examples

        iex> create_bucket_txs(%{field: value})
        {:ok, %BucketTxs{}}

        iex> create_bucket_txs(%{field: bad_value})
        {:error, %Ecto.Changeset{}}

    """
    def create_bucket_txs(attrs) do
      Buckets.create_bucket_txs(attrs)
    end

    def create_new_bucket_transaction(attrs) do
      Buckets.create_new_bucket_transaction(Map.merge(attrs, %{"is_spent" => 0, "locket_4_tx" => 0}))
    end

    def create_new_buckets_for_swap(attrs, list_buckets_ids) do
      sum = Buckets.get_sum_buckets_by_list_ids(list_buckets_ids)
      Buckets.create_new_bucket_transaction_for_swap(Map.merge(attrs, %{"amount" => sum}), list_buckets_ids)
    end

    def create_transaction_burn_buckets(attrs, list_bucket_ids) do
      Buckets.create_transaction_burn_buckets(attrs, list_bucket_ids)
    end

    def create_new_buckets_for_partitions(attrs, amount, list_buckets_ids) do
      sum_from_buckets = Buckets.get_sum_buckets_by_list_ids(list_buckets_ids)

      if amount <= sum_from_buckets do
         remain = sum_from_buckets - amount
        Buckets.create_new_bucket_transaction_for_new_buckets(attrs, amount, remain, list_buckets_ids)
      else
        {:error, %{"message" => "El monto es superior a lo que tiene en cuenta"} }
      end
    end


    def create_new_bucket_transaction_for_expand(attrs, bucket_in, list_attrs_for_buckets_destination) do

      amount = Enum.reduce(list_attrs_for_buckets_destination, fn x, acc -> x["amount"] + acc["amount"] end) |> Decimal.new()

      IO.inspect(Decimal.compare(bucket_in.amount, amount))
      if Decimal.compare(bucket_in.amount, amount) == :gt do
        Buckets.create_new_bucket_transaction_for_expand(attrs, bucket_in, list_attrs_for_buckets_destination)
      else
        {:error, %{"message" => "No se puede realizar la transacción por que el monto es superior al origen"}}
      end

    end


    def validate_struct_for_bucket_destination(list_attrs_bucket) do
      for attrs_bucket <- list_attrs_bucket do
        if %BucketForExpand{} == attrs_bucket do
          attrs_bucket
        end
      end

    end


    def test_new_bucket_expand do
      map = %{
        "amount" => "800",
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
        "type" => "expand",
        "wallet_from" => "iri.efectivo",
        "wallet_to" => "irl.efectivo"
      }

      list = [
        %{
          "amount" => 200,
          "asset" => "MXN",
          "is_spent" => 0,
          "lock_4_tx" => 0,
          "owner_to" => "cliente 25",
          "wallet_to" => "ilr.cash"
        },
        %{
          "amount" => 800,
          "asset" => "MXN",
          "is_spent" => 0,
          "lock_4_tx" => 0,
          "owner_to" => "cliente 25",
          "wallet_to" => "ilr.cash"
        },

      ]

      bucket_in = get_bucket!("51daa1bc-96a4-4183-8ef7-454f8d8272c3")



      create_new_bucket_transaction_for_expand(map, bucket_in, list)

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
        "wallet_to" => "irl.efectivo",
        "is_spent" => 0,
        "locket_4_tx" => 1,
      }


      create_new_buckets_for_swap(map, ["bucket_1002", "bucket_1003", "bucket_1004"])

    end


    def generate_hash(map) do
     Buckets.generate_hash(map)
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
      Buckets.update_bucket_txs(bucket_txs, attrs)
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
      Buckets.delete_bucket_txs(bucket_txs)
    end

    @doc """
    Returns an `%Ecto.Changeset{}` for tracking bucket_txs changes.

    ## Examples

        iex> change_bucket_txs(bucket_txs)
        %Ecto.Changeset{data: %BucketTxs{}}

    """
    def change_bucket_txs(bucket_txs) do
      Buckets.change_bucket_txs(bucket_txs)
    end
    def change_bucket_txs(bucket_txs, attrs) do
      Buckets.change_bucket_txs(bucket_txs, attrs)
    end
    ########################################
    # LedgersBuckets.Buckets.BucketTxFrom
    ########################################

    @doc """
    Returns the list of bucket_tx_from.

    ## Examples

        iex> list_bucket_tx_from()
        [%BucketTxFrom{}, ...]

    """
    def list_bucket_tx_from do
      Buckets.list_bucket_tx_from()
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
    def get_bucket_tx_from!(id), do: Buckets.get_bucket_tx_from!(id)

    @doc """
    Creates a bucket_tx_from.

    ## Examples

        iex> create_bucket_tx_from(%{field: value})
        {:ok, %BucketTxFrom{}}

        iex> create_bucket_tx_from(%{field: bad_value})
        {:error, %Ecto.Changeset{}}

    """
    def create_bucket_tx_from(attrs) do
      Buckets.create_bucket_tx_from(attrs)
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
      Buckets.update_bucket_tx_from(bucket_tx_from, attrs)
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
      Buckets.delete_bucket_tx_from(bucket_tx_from)
    end

    @doc """
    Returns an `%Ecto.Changeset{}` for tracking bucket_tx_from changes.

    ## Examples

        iex> change_bucket_tx_from(bucket_tx_from)
        %Ecto.Changeset{data: %BucketTxFrom{}}

    """
    def change_bucket_tx_from(bucket_tx_from) do
      Buckets.change_bucket_tx_from(bucket_tx_from)
    end

    def change_bucket_tx_from(bucket_tx_from, attrs) do
      Buckets.change_bucket_tx_from(bucket_tx_from, attrs)
    end
    #####################################
    #LedgersBuckets.Buckets.BucketTxTo
    #####################################
    @doc """
    Returns the list of bucket_tx_to.

    ## Examples

        iex> list_bucket_tx_to()
        [%BucketTxTo{}, ...]

    """
    def list_bucket_tx_to do
      Buckets.list_bucket_tx_to()
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
    def get_bucket_tx_to!(id), do: Buckets.get_bucket_tx_to!(id)

    @doc """
    Creates a bucket_tx_to.

    ## Examples

        iex> create_bucket_tx_to(%{field: value})
        {:ok, %BucketTxTo{}}

        iex> create_bucket_tx_to(%{field: bad_value})
        {:error, %Ecto.Changeset{}}

    """
    def create_bucket_tx_to(attrs) do
      Buckets.create_bucket_tx_to(attrs)
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
      Buckets.update_bucket_tx_to(bucket_tx_to, attrs)
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
      Buckets.delete_bucket_tx_to(bucket_tx_to)
    end

    @doc """
    Returns an `%Ecto.Changeset{}` for tracking bucket_tx_to changes.

    ## Examples

        iex> change_bucket_tx_to(bucket_tx_to)
        %Ecto.Changeset{data: %BucketTxTo{}}

    """
    def change_bucket_tx_to(bucket_tx_to) do
      Buckets.change_bucket_tx_to(bucket_tx_to)
    end

    def change_bucket_tx_to(bucket_tx_to, attrs) do
      Buckets.change_bucket_tx_to(bucket_tx_to, attrs)
    end
    ###########################################################
    #alias LedgersBuckets.Buckets.Bucket
    ###########################################################
    @doc """
    Returns the list of buckets.

    ## Examples

        iex> list_buckets()
        [%Bucket{}, ...]

    """
    def list_buckets do
      Buckets.list_buckets()
    end


    def list_buckets_by_list_ids(list_bucket_ids) do
      Buckets.list_buckets_by_list_ids(list_bucket_ids)
    end

    def get_sum_buckets_by_list_ids(list_bucket_ids) do
     Buckets.get_sum_buckets_by_list_ids(list_bucket_ids)
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
    def get_bucket!(id), do: Buckets.get_bucket!(id)


    def search_and_get_free_buckets(bucket_tx_id) do
      Buckets.search_and_get_free_buckets(bucket_tx_id)
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
      Buckets.create_bucket(attrs)
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
      Buckets.update_bucket(bucket, attrs)
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
      Buckets.delete_many_buckets(list_buckets_ids)
    end

    def delete_bucket(bucket) do
      Buckets.delete_bucket(bucket)
    end

    @doc """
    Returns an `%Ecto.Changeset{}` for tracking bucket changes.

    ## Examples

        iex> change_bucket(bucket)
        %Ecto.Changeset{data: %Bucket{}}

    """
    def change_bucket(bucket) do
      Buckets.change_bucket(bucket)
    end
    def change_bucket(bucket, attrs) do
      Buckets.change_bucket(bucket, attrs)
    end

    ##############################################
    #LedgersBuckets.Buckets.BucketFlow
    ##############################################

    @doc """
    Returns the list of bucket_flows.

    ## Examples

        iex> list_bucket_flows()
        [%BucketFlow{}, ...]

    """
    def list_bucket_flows do
      Buckets.list_bucket_flows()
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
    def get_bucket_flow!(id), do: Buckets.get_bucket_flow!(id)

    @doc """
    Creates a bucket_flow.

    ## Examples

        iex> create_bucket_flow(%{field: value})
        {:ok, %BucketFlow{}}

        iex> create_bucket_flow(%{field: bad_value})
        {:error, %Ecto.Changeset{}}

    """
    def create_bucket_flow(attrs) do
      Buckets.create_bucket_flow(attrs)
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
      Buckets.update_bucket_flow(bucket_flow, attrs)
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
      Buckets.delete_bucket_flow(bucket_flow)
    end

    @doc """
    Returns an `%Ecto.Changeset{}` for tracking bucket_flow changes.

    ## Examples

        iex> change_bucket_flow(bucket_flow)
        %Ecto.Changeset{data: %BucketFlow{}}

    """
    def change_bucket_flow(bucket_flow) do
      Buckets.change_bucket_flow(bucket_flow)
    end

    def change_bucket_flow(bucket_flow, attrs) do
      Buckets.change_bucket_flow(bucket_flow, attrs)
    end
end
