defmodule LedgersBucketsWeb.BucketTxToLive.FormComponent do
  use LedgersBucketsWeb, :live_component

  alias EdgeGateeay.Api.BucketsApex

  @impl true
  def update(%{bucket_tx_to: bucket_tx_to} = assigns, socket) do
    changeset = BucketsApex.change_bucket_tx_to(bucket_tx_to)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"bucket_tx_to" => bucket_tx_to_params}, socket) do
    changeset =
      socket.assigns.bucket_tx_to
      |> BucketsApex.change_bucket_tx_to(bucket_tx_to_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"bucket_tx_to" => bucket_tx_to_params}, socket) do
    save_bucket_tx_to(socket, socket.assigns.action, bucket_tx_to_params)
  end

  defp save_bucket_tx_to(socket, :edit, bucket_tx_to_params) do
    case BucketsApex.update_bucket_tx_to(socket.assigns.bucket_tx_to, bucket_tx_to_params) do
      {:ok, _bucket_tx_to} ->
        {:noreply,
         socket
         |> put_flash(:info, "Bucket tx to updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_bucket_tx_to(socket, :new, bucket_tx_to_params) do
    case BucketsApex.create_bucket_tx_to(bucket_tx_to_params) do
      {:ok, _bucket_tx_to} ->
        {:noreply,
         socket
         |> put_flash(:info, "Bucket tx to created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
