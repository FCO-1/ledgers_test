defmodule Core.Transactions do
  @moduledoc """
  The Transactions context.
  """

  import Ecto.Query, warn: false
  alias Core.Repo

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
