defmodule Core.Transaccions do
  @moduledoc """
  The Transaccions context.
  """

  import Ecto.Query, warn: false
  alias Core.Repo

  alias Core.Transaccions.TxTest

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
end
