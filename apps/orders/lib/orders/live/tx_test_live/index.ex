defmodule Orders.TxTestLive.Index do
  use Orders, :live_view

  alias Core.Transaccions
  alias Core.Transaccions.TxTest

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :tx_tests, list_tx_tests())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Tx test")
    |> assign(:tx_test, Transaccions.get_tx_test!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Tx test")
    |> assign(:tx_test, %TxTest{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Tx tests")
    |> assign(:tx_test, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    tx_test = Transaccions.get_tx_test!(id)
    {:ok, _} = Transaccions.delete_tx_test(tx_test)

    {:noreply, assign(socket, :tx_tests, list_tx_tests())}
  end

  defp list_tx_tests do
    Transaccions.list_tx_tests()
  end
end
