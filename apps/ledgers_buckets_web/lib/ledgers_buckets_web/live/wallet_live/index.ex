defmodule LedgersBucketsWeb.WalletLive.Index do
  use LedgersBucketsWeb, :live_view

  alias LedgersBuckets.Context.AccountBooks
  alias LedgersBuckets.AccountBooks.Wallet

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :wallets, list_wallets())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Wallet")
    |> assign(:wallet, AccountBooks.get_wallet!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Wallet")
    |> assign(:wallet, %Wallet{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Wallets")
    |> assign(:wallet, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    wallet = AccountBooks.get_wallet!(id)
    {:ok, _} = AccountBooks.delete_wallet(wallet)

    {:noreply, assign(socket, :wallets, list_wallets())}
  end

  defp list_wallets do
    AccountBooks.list_wallets()
  end
end
