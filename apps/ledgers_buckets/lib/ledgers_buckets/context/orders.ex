defmodule LedgersBuckets.Context.Orders do
  @moduledoc """
  The Orders context.
  """

  import Ecto.Query, warn: false
  alias LedgersBuckets.Schemas.Buckets
  alias LedgersBuckets.Repo

  alias LedgersBuckets.Orders.Order
  alias LedgersBuckets.Orders.OrderBucketTxs
  alias LedgersBuckets.Domain.BucketsDomain
  alias LedgersBuckets.Buckets
  alias LedgersBuckets.Context.AccountBooks
  alias LedgersBuckets.Context.FunctionsCommons


  @doc """
  Returns the list of orders.

  ## Examples

      iex> list_orders()
      [%Order{}, ...]

  """
  def list_orders do
    Repo.all(Order)
  end

  @doc """
  Gets a single order.

  Raises `Ecto.NoResultsError` if the Order does not exist.

  ## Examples

      iex> get_order!(123)
      %Order{}

      iex> get_order!(456)
      ** (Ecto.NoResultsError)

  """
  def get_order!(id), do: Repo.get!(Order, id)

  @doc """
  Creates a order.

  ## Examples

      iex> create_order(%{field: value})
      {:ok, %Order{}}

      iex> create_order(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_order(attrs \\ %{}) do
    %Order{}
    |> Order.changeset(attrs)
    |> Repo.insert()
  end



  def create_new_order_for_new_client(attrs,wallet_from, wallet_to ) do
   attrs =  FunctionsCommons.convert_params(attrs)
    wallet_mint = AccountBooks.get_default_account_mint_for_clients().path
    wallet_client_irl = AccountBooks.get_default_pre_account_for_clients().path
    Repo.transaction(fn ->
      with {:ok, order} <- build_order(attrs) |> create_order(),
      {:ok, bucket_tx} <- build_new_bucket_for_order(Map.merge(attrs, %{"type" => "mint"}), order, nil, wallet_mint ) |> BucketsDomain.create_new_bucket_transaction(),
      {:ok, bucket_transacction1} <- build_new_bucket_for_order(attrs, order, wallet_mint, wallet_client_irl) |> Buckets.create_transaction_new_buckets_for_transfer_one_to_one(bucket_tx.bucket |> List.first() ),
      {:ok, _bucket_transacction2} <- build_new_bucket_for_order(attrs, order, wallet_client_irl, wallet_to) |> Buckets.create_transaction_new_buckets_for_transfer_one_to_one(bucket_transacction1.bucket |> List.first()) do
      order
    end

      end)
  end


  def build_order(params) do
    params = FunctionsCommons.convert_params(params)
    %{
      amount: params["amount"],
      extras: params["extras"],
      flags: params["flags"],
      from: params["from"],
      order_id: params["order_id"],
      owner: params["owner"],
      state: params["state"],
      status: params["status"],
      to: params["to"],
      type: params["type"],
      wallet_to: params["wallet_to"]
    }
  end


  def build_order_tx(order, type \\ "ledger_buckets", bucket_txs) do
    %{
      order_id: order.order_id,
      reference_id: bucket_txs.id,
      reference_type: type,
    }
  end

  def build_new_bucket_for_order(params, order, wallet_from \\ nil, wallet_to) do
     new_params = FunctionsCommons.convert_params(params)
     new_order = Map.from_struct(order) |>  FunctionsCommons.convert_params()
    %{
      "amount" => new_params["amount"],
      "asset" => new_params["asset"],
      "bucket_tx_at" => NaiveDateTime.local_now(),
      "note" => "cliente a cliente",
      "owner_from" => new_params["from"],
      "owner_to" => new_params["to"],
      "reference_id" => new_order["order_id"],
      "reference_type" => "order",
      "request_id" => new_params["reference_id"],
      "state" => "complete",
      "status" => "open",
      "type" => new_params["type"],
      "wallet_from" => wallet_from,
      "wallet_to" => wallet_to,
      "is_spent" => 0,
      "locket_4_tx" => 1,
    }
  end



  def test_create_new_order do
    map = %{
      amount: 200,
      extras: %{},
      flags: "complete",
      from: "cliente",
      order_id: "order_001",
      reference_id: Ecto.UUID.autogenerate(),
      reference_type: "document",
      state: "complete",
      status: "open",
      to: "vendedor1",
      type: "deposit",
      asset: "MXN",
      owner: "vendedor1",
      wallet_to: "money.seller.cash.deposit"
    }

    create_new_order_for_new_client(map, nil, "money.seller.cash.deposit")
  end

  @doc """
  Updates a order.

  ## Examples

      iex> update_order(order, %{field: new_value})
      {:ok, %Order{}}

      iex> update_order(order, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_order(%Order{} = order, attrs) do
    order
    |> Order.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a order.

  ## Examples

      iex> delete_order(order)
      {:ok, %Order{}}

      iex> delete_order(order)
      {:error, %Ecto.Changeset{}}

  """
  def delete_order(%Order{} = order) do
    Repo.delete(order)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking order changes.

  ## Examples

      iex> change_order(order)
      %Ecto.Changeset{data: %Order{}}

  """
  def change_order(%Order{} = order, attrs \\ %{}) do
    Order.changeset(order, attrs)
  end

  ##########################################################
  #LedgersBuckets.Orders.OrderBucketTxs

  @doc """
  Returns the list of order_bucket_txs.

  ## Examples

      iex> list_order_bucket_txs()
      [%OrderBucketTxs{}, ...]

  """
  def list_order_bucket_txs do
    Repo.all(OrderBucketTxs)
  end

  @doc """
  Gets a single order_bucket_txs.

  Raises `Ecto.NoResultsError` if the Order bucket txs does not exist.

  ## Examples

      iex> get_order_bucket_txs!(123)
      %OrderBucketTxs{}

      iex> get_order_bucket_txs!(456)
      ** (Ecto.NoResultsError)

  """
  def get_order_bucket_txs!(id), do: Repo.get!(OrderBucketTxs, id)

  @doc """
  Creates a order_bucket_txs.

  ## Examples

      iex> create_order_bucket_txs(%{field: value})
      {:ok, %OrderBucketTxs{}}

      iex> create_order_bucket_txs(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_order_bucket_txs(attrs \\ %{}) do
    %OrderBucketTxs{}
    |> OrderBucketTxs.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a order_bucket_txs.

  ## Examples

      iex> update_order_bucket_txs(order_bucket_txs, %{field: new_value})
      {:ok, %OrderBucketTxs{}}

      iex> update_order_bucket_txs(order_bucket_txs, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_order_bucket_txs(%OrderBucketTxs{} = order_bucket_txs, attrs) do
    order_bucket_txs
    |> OrderBucketTxs.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a order_bucket_txs.

  ## Examples

      iex> delete_order_bucket_txs(order_bucket_txs)
      {:ok, %OrderBucketTxs{}}

      iex> delete_order_bucket_txs(order_bucket_txs)
      {:error, %Ecto.Changeset{}}

  """
  def delete_order_bucket_txs(%OrderBucketTxs{} = order_bucket_txs) do
    Repo.delete(order_bucket_txs)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking order_bucket_txs changes.

  ## Examples

      iex> change_order_bucket_txs(order_bucket_txs)
      %Ecto.Changeset{data: %OrderBucketTxs{}}

  """
  def change_order_bucket_txs(%OrderBucketTxs{} = order_bucket_txs, attrs \\ %{}) do
    OrderBucketTxs.changeset(order_bucket_txs, attrs)
  end

end
