defmodule Core.DomainTransactions do
  @moduledoc """
  The Transactions context.
  """

alias Core.Transactions

  @doc """
  Returns the list of tx_tests.

  ## Examples

      iex> list_tx_tests()
      [%TxTest{}, ...]

  """
  def list_tx_tests do
    Transactions.list_tx_tests()
  end

  @doc """
  Gets a single tx_test.

  Raises `Ecto.NoResultsError` if the Tx test does not exist.

  ## Examples

      iex> get_tx_test!(123)
      %TxTest{}

      iex> get_tx_test!(456)
      ** (Ecto.NoResultsError)

  """
  def get_tx_test!(id), do: Transactions.get_tx_test!(id)

  @doc """
  Creates a tx_test.

  ## Examples

      iex> create_tx_test(%{field: value})
      {:ok, %TxTest{}}

      iex> create_tx_test(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_tx_test(attrs) do
   Transactions.create_tx_test(attrs)
  end

  @doc """
  Updates a tx_test.

  ## Examples

      iex> update_tx_test(tx_test, %{field: new_value})
      {:ok, %TxTest{}}

      iex> update_tx_test(tx_test, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_tx_test(tx_test, attrs) do
    Transactions.update_tx_test(tx_test, attrs)
  end

  @doc """
  Deletes a tx_test.

  ## Examples

      iex> delete_tx_test(tx_test)
      {:ok, %TxTest{}}

      iex> delete_tx_test(tx_test)
      {:error, %Ecto.Changeset{}}

  """
  def delete_tx_test(tx_test) do
    Transactions.delete_tx_test(tx_test)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking tx_test changes.

  ## Examples

      iex> change_tx_test(tx_test)
      %Ecto.Changeset{data: %TxTest{}}

  """
  def change_tx_test(tx_test, attrs) do
    Transactio.change_tx_test(tx_test, attrs)
  end
#########################################################
 #Core.Transactions.Utxio

  @doc """
  Returns the list of utxio.

  ## Examples

      iex> list_utxio()
      [%Utxio{}, ...]

  """
  def list_utxio do
    Transactions.list_utxio()
  end

  @doc """
  Gets a single utxio.

  Raises `Ecto.NoResultsError` if the Utxio does not exist.

  ## Examples

      iex> get_utxio!(123)
      %Utxio{}

      iex> get_utxio!(456)
      ** (Ecto.NoResultsError)

  """
  def get_utxio!(id), do: Transactions.get_utxio!()

  @doc """
  Creates a utxio.

  ## Examples

      iex> create_utxio(%{field: value})
      {:ok, %Utxio{}}

      iex> create_utxio(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_utxio(attrs) do
   Transactions.create_utxio(attrs)
  end

  @doc """
  Updates a utxio.

  ## Examples

      iex> update_utxio(utxio, %{field: new_value})
      {:ok, %Utxio{}}

      iex> update_utxio(utxio, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_utxio(utxio, attrs) do
    Transactions.update_utxio(utxio, attrs)
  end

  @doc """
  Deletes a utxio.

  ## Examples

      iex> delete_utxio(utxio)
      {:ok, %Utxio{}}

      iex> delete_utxio(utxio)
      {:error, %Ecto.Changeset{}}

  """
  def delete_utxio(utxio) do
    Transactions.delete_utxio(utxio)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking utxio changes.

  ## Examples

      iex> change_utxio(utxio)
      %Ecto.Changeset{data: %Utxio{}}

  """
  def change_utxio(utxio) do
    Transactions.delete_utxio(utxio)
  end
  def change_utxio(utxio, attrs) do
    Transactions.delete_utxio(utxio, attrs)
  end
end
