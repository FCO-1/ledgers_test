defmodule LedgersBucketsWeb.OrderBucketTxsLive.FormComponent do
  use LedgersBucketsWeb, :live_component

  alias LedgersBuckets.Orders

  @impl true
  def update(%{order_bucket_txs: order_bucket_txs} = assigns, socket) do
    changeset = Orders.change_order_bucket_txs(order_bucket_txs)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"order_bucket_txs" => order_bucket_txs_params}, socket) do
    changeset =
      socket.assigns.order_bucket_txs
      |> Orders.change_order_bucket_txs(order_bucket_txs_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"order_bucket_txs" => order_bucket_txs_params}, socket) do
    save_order_bucket_txs(socket, socket.assigns.action, order_bucket_txs_params)
  end

  defp save_order_bucket_txs(socket, :edit, order_bucket_txs_params) do
    case Orders.update_order_bucket_txs(socket.assigns.order_bucket_txs, order_bucket_txs_params) do
      {:ok, _order_bucket_txs} ->
        {:noreply,
         socket
         |> put_flash(:info, "Order bucket txs updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_order_bucket_txs(socket, :new, order_bucket_txs_params) do
    case Orders.create_order_bucket_txs(order_bucket_txs_params) do
      {:ok, _order_bucket_txs} ->
        {:noreply,
         socket
         |> put_flash(:info, "Order bucket txs created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
