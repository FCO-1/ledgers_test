defmodule LedgersBucketsWeb.BucketTxFromLive.FormComponent do
  use LedgersBucketsWeb, :live_component

  alias EdgeGateeay.Api.BucketsApex

  @impl true
  def update(%{bucket_tx_from: bucket_tx_from} = assigns, socket) do
    changeset = BucketsApex.change_bucket_tx_from(bucket_tx_from)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"bucket_tx_from" => bucket_tx_from_params}, socket) do
    changeset =
      socket.assigns.bucket_tx_from
      |> BucketsApex.change_bucket_tx_from(bucket_tx_from_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"bucket_tx_from" => bucket_tx_from_params}, socket) do
    save_bucket_tx_from(socket, socket.assigns.action, bucket_tx_from_params)
  end

  defp save_bucket_tx_from(socket, :edit, bucket_tx_from_params) do
    case BucketsApex.update_bucket_tx_from(socket.assigns.bucket_tx_from, bucket_tx_from_params) do
      {:ok, _bucket_tx_from} ->
        {:noreply,
         socket
         |> put_flash(:info, "Bucket tx from updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_bucket_tx_from(socket, :new, bucket_tx_from_params) do
    case BucketsApex.create_bucket_tx_from(bucket_tx_from_params) do
      {:ok, _bucket_tx_from} ->
        {:noreply,
         socket
         |> put_flash(:info, "Bucket tx from created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
