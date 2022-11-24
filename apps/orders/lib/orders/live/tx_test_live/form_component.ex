defmodule Orders.TxTestLive.FormComponent do
  use Orders, :live_component

  alias Core.Transactions

  @impl true
  def update(%{tx_test: tx_test} = assigns, socket) do
    changeset = Transaccions.change_tx_test(tx_test)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"tx_test" => tx_test_params}, socket) do
    changeset =
      socket.assigns.tx_test
      |> Transaccions.change_tx_test(tx_test_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"tx_test" => tx_test_params}, socket) do
    save_tx_test(socket, socket.assigns.action, tx_test_params)
  end

  defp save_tx_test(socket, :edit, tx_test_params) do
    case Transaccions.update_tx_test(socket.assigns.tx_test, tx_test_params) do
      {:ok, _tx_test} ->
        {:noreply,
         socket
         |> put_flash(:info, "Tx test updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_tx_test(socket, :new, tx_test_params) do
    case Transaccions.create_tx_test(tx_test_params) do
      {:ok, _tx_test} ->
        {:noreply,
         socket
         |> put_flash(:info, "Tx test created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
