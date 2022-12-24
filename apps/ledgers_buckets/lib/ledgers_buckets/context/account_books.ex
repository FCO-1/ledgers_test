defmodule LedgersBuckets.Context.AccountBooks do
  @moduledoc """
  The AccountBooks context.
  """

  import Ecto.Query, warn: false
  alias LedgersBuckets.Repo

  alias LedgersBuckets.AccountBooks.Wallet

  @doc """
  Returns the list of wallets.

  ## Examples

      iex> list_wallets()
      [%Wallet{}, ...]

  """
  def list_wallets do
    Repo.all(Wallet)
  end



  @doc """
  Gets a single wallet.

  Raises `Ecto.NoResultsError` if the Wallet does not exist.

  ## Examples

      iex> get_wallet!(123)
      %Wallet{}

      iex> get_wallet!(456)
      ** (Ecto.NoResultsError)

  """
  def get_wallet!(id), do: Repo.get!(Wallet, id)

  def get_default_account_for_new_clients do
    Wallet
    |> where([s], s.path == "cliente.funding.disponible")
    |> Repo.all()
    |> List.first()
  end

  def get_default_account_mint_for_clients do
    Wallet
    |> where([s], s.path == "cmd.mint")
    |> Repo.all()
    |> List.first()
  end

  def get_default_pre_account_for_clients do
    Wallet
    |> where([s], s.path == "irl.cash")
    |> Repo.all()
    |> List.first()
  end

  def get_funding_account_for_clients do
    Wallet
    |> where([s], s.path == "cliente.funding.disponible")
    |> Repo.all()
    |> List.first()
  end

  #############################################
  # Funciones para obtener wallets de docuemtos
  ############################################

  def get_default_documents_credits do
    Wallet
    |> where([s], s.path == "documents.credit")
    |> Repo.all()
    |> List.first()
  end

  def get_default_documents_funding do
    Wallet
    |> where([s], s.path == "documents.funding")
    |> Repo.all()
    |> List.first()
  end


  @doc """
  Creates a wallet.

  ## Examples

      iex> create_wallet(%{field: value})
      {:ok, %Wallet{}}

      iex> create_wallet(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_wallet(attrs \\ %{}) do
    %Wallet{}
    |> Wallet.changeset(attrs)
    |> Repo.insert()
  end



  @doc """
  Updates a wallet.

  ## Examples

      iex> update_wallet(wallet, %{field: new_value})
      {:ok, %Wallet{}}

      iex> update_wallet(wallet, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_wallet(%Wallet{} = wallet, attrs) do
    wallet
    |> Wallet.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a wallet.

  ## Examples

      iex> delete_wallet(wallet)
      {:ok, %Wallet{}}

      iex> delete_wallet(wallet)
      {:error, %Ecto.Changeset{}}

  """
  def delete_wallet(%Wallet{} = wallet) do
    Repo.delete(wallet)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking wallet changes.

  ## Examples

      iex> change_wallet(wallet)
      %Ecto.Changeset{data: %Wallet{}}

  """
  def change_wallet(%Wallet{} = wallet, attrs \\ %{}) do
    Wallet.changeset(wallet, attrs)
  end
end
