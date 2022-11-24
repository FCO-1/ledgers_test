defmodule Orders.UtxioLive.Show do
  use Orders, :live_view

  alias Core.Transactions

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:utxio, Transactions.get_utxio!(id))}
  end

  defp page_title(:show), do: "Show Utxio"
  defp page_title(:edit), do: "Edit Utxio"
end
