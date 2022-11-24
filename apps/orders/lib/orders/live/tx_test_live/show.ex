defmodule Orders.TxTestLive.Show do
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
     |> assign(:tx_test, Transaccions.get_tx_test!(id))}
  end

  defp page_title(:show), do: "Show Tx test"
  defp page_title(:edit), do: "Edit Tx test"
end
