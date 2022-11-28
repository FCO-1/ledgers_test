defmodule Core.Transactions do
  @moduledoc """
  The Transactions context.
  """

  import Ecto.Query, warn: false
  alias Core.Repo

  alias Core.Transactions.TxTest

  alias Core.Buckets
  @doc """
  Returns the list of tx_tests.

  ## Examples

      iex> list_tx_tests()
      [%TxTest{}, ...]

  """
  def list_tx_tests do
    Repo.all(TxTest)
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
  def get_tx_test!(id), do: Repo.get!(TxTest, id)

  @doc """
  Creates a tx_test.

  ## Examples

      iex> create_tx_test(%{field: value})
      {:ok, %TxTest{}}

      iex> create_tx_test(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_tx_test(attrs \\ %{}) do
    %TxTest{}
    |> TxTest.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a tx_test.

  ## Examples

      iex> update_tx_test(tx_test, %{field: new_value})
      {:ok, %TxTest{}}

      iex> update_tx_test(tx_test, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_tx_test(%TxTest{} = tx_test, attrs) do
    tx_test
    |> TxTest.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a tx_test.

  ## Examples

      iex> delete_tx_test(tx_test)
      {:ok, %TxTest{}}

      iex> delete_tx_test(tx_test)
      {:error, %Ecto.Changeset{}}

  """
  def delete_tx_test(%TxTest{} = tx_test) do
    Repo.delete(tx_test)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking tx_test changes.

  ## Examples

      iex> change_tx_test(tx_test)
      %Ecto.Changeset{data: %TxTest{}}

  """
  def change_tx_test(%TxTest{} = tx_test, attrs \\ %{}) do
    TxTest.changeset(tx_test, attrs)
  end

  alias Core.Transactions.Utxio

  @doc """
  Returns the list of utxio.

  ## Examples

      iex> list_utxio()
      [%Utxio{}, ...]

  """
  def list_utxio do
    Repo.all(Utxio)
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
  def get_utxio!(id), do: Repo.get!(Utxio, id)

  @doc """
  Creates a utxio.

  ## Examples

      iex> create_utxio(%{field: value})
      {:ok, %Utxio{}}

      iex> create_utxio(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_utxio(attrs \\ %{}) do
    %Utxio{}
    |> Utxio.changeset(attrs)
    |> Repo.insert()
  end

  def create_tx(attrs) do
    result = Repo.transaction(fn ->
      with {:ok, _tx} <- build_transaccion(attrs) |> create_utxio() ,
      {:ok, buckekt} <- Buckets.build_bucket_table(attrs) |> Buckets.create_bucket_table() do
        buckekt
      end
    end)

    {:ok, result}
  end

  def build_transaccion(attrs) do
    %{
    assetmedio: attrs["assetmedio"],
    object_id: attrs["object_id"],
    size: attrs["size"],
    tx_reference_id: attrs["tx_reference_id"]
    }
  end

  @doc """
  Updates a utxio.

  ## Examples

      iex> update_utxio(utxio, %{field: new_value})
      {:ok, %Utxio{}}

      iex> update_utxio(utxio, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_utxio(%Utxio{} = utxio, attrs) do
    utxio
    |> Utxio.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a utxio.

  ## Examples

      iex> delete_utxio(utxio)
      {:ok, %Utxio{}}

      iex> delete_utxio(utxio)
      {:error, %Ecto.Changeset{}}

  """
  def delete_utxio(%Utxio{} = utxio) do
    Repo.delete(utxio)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking utxio changes.

  ## Examples

      iex> change_utxio(utxio)
      %Ecto.Changeset{data: %Utxio{}}

  """
  def change_utxio(%Utxio{} = utxio, attrs \\ %{}) do
    Utxio.changeset(utxio, attrs)
  end
end
