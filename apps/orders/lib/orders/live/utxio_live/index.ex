defmodule Orders.UtxioLive.Index do
  use Orders, :live_view

  alias Core.Transactions
  alias Core.Transactions.Utxio

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :utxio_collection, list_utxio())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Utxio")
    |> assign(:utxio, Transactions.get_utxio!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Utxio")
    |> assign(:utxio, %Utxio{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Utxio")
    |> assign(:utxio, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    utxio = Transactions.get_utxio!(id)
    {:ok, _} = Transactions.delete_utxio(utxio)

    {:noreply, assign(socket, :utxio_collection, list_utxio())}
  end

  defp list_utxio do
    Transactions.list_utxio()
  end
end
