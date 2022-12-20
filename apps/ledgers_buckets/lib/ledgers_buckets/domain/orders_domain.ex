defmodule LedgersBuckets.Domaim.Orders do
  @moduledoc """
  The Orders context.
  """
  alias LedgersBuckets.Context.Orders


  @doc """
  Returns the list of orders.

  ## Examples

      iex> list_orders()
      [%Order{}, ...]

  """
  def list_orders do
    Orders.list_orders()
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
  def get_order!(id), do: Orders.get_order!(id)

  @doc """
  Creates a order.

  ## Examples

      iex> create_order(%{field: value})
      {:ok, %Order{}}

      iex> create_order(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_order(attrs) do
    Orders.create_order(attrs)
  end

  def create_new_order_for_new_client(attrs, wallet_from, wallet_to ) do
    Orders.create_new_order_for_new_client(attrs, wallet_from, wallet_to)
  end

  def create_new_order_for_new_client(attrs,wallet_from, wallet_to ) do
    Orders.create_new_order_for_new_client(attrs,wallet_from, wallet_to )
  end

  @doc """
  Updates a order.

  ## Examples

      iex> update_order(order, %{field: new_value})
      {:ok, %Order{}}

      iex> update_order(order, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_order(order, attrs) do
    Orders.update_order(order, attrs)
  end

  @doc """
  Deletes a order.

  ## Examples

      iex> delete_order(order)
      {:ok, %Order{}}

      iex> delete_order(order)
      {:error, %Ecto.Changeset{}}

  """
  def delete_order(order) do
    Orders.delete_order(order)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking order changes.

  ## Examples

      iex> change_order(order)
      %Ecto.Changeset{data: %Order{}}

  """
  def change_order(order) do
    Orders.change_order(order)
  end
  def change_order(order, attrs) do
    Orders.change_order(order, attrs)
  end

  ##########################################################
  #LedgersBuckets.Orders.OrderBucketTxs
  ##########################################################

  @doc """
  Returns the list of order_bucket_txs.

  ## Examples

      iex> list_order_bucket_txs()
      [%OrderBucketTxs{}, ...]

  """
  def list_order_bucket_txs do
    Orders.list_order_bucket_txs()
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
  def get_order_bucket_txs!(id), do: Orders.get_order_bucket_txs!(id)

  @doc """
  Creates a order_bucket_txs.

  ## Examples

      iex> create_order_bucket_txs(%{field: value})
      {:ok, %OrderBucketTxs{}}

      iex> create_order_bucket_txs(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_order_bucket_txs(attrr) do
    Orders.create_order_bucket_txs(attrr)
  end

  @doc """
  Updates a order_bucket_txs.

  ## Examples

      iex> update_order_bucket_txs(order_bucket_txs, %{field: new_value})
      {:ok, %OrderBucketTxs{}}

      iex> update_order_bucket_txs(order_bucket_txs, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_order_bucket_txs(order_bucket_txs, attrs) do
    Orders.update_order_bucket_txs(order_bucket_txs, attrs)
  end

  @doc """
  Deletes a order_bucket_txs.

  ## Examples

      iex> delete_order_bucket_txs(order_bucket_txs)
      {:ok, %OrderBucketTxs{}}

      iex> delete_order_bucket_txs(order_bucket_txs)
      {:error, %Ecto.Changeset{}}

  """
  def delete_order_bucket_txs(order_bucket_txs) do
    Orders.delete_order_bucket_txs(order_bucket_txs)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking order_bucket_txs changes.

  ## Examples

      iex> change_order_bucket_txs(order_bucket_txs)
      %Ecto.Changeset{data: %OrderBucketTxs{}}

  """
  def change_order_bucket_txs(order_bucket_txs) do
    Orders.change_order_bucket_txs(order_bucket_txs)
  end
  def change_order_bucket_txs(order_bucket_txs, attrs) do
    Orders.change_order_bucket_txs(order_bucket_txs, attrs)
  end

end
