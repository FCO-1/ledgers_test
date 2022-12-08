defmodule LedgersBucketsWeb.BucketTxsLive.FormComponent do
  use LedgersBucketsWeb, :live_component

  alias LedgersBuckets.Buckets
  alias LedgersBuckets.Domain.BucketsDomain

  @impl true
  def update(%{bucket_txs: bucket_txs} = assigns, socket) do
    changeset = Buckets.change_bucket_txs(bucket_txs)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"bucket_txs" => bucket_txs_params}, socket) do
    IO.inspect(bucket_txs_params)
    changeset =
      socket.assigns.bucket_txs
      |> Buckets.change_bucket_txs(bucket_txs_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"bucket_txs" => bucket_txs_params}, socket) do
    save_bucket_txs(socket, socket.assigns.action, bucket_txs_params)
  end

  defp save_bucket_txs(socket, :edit, bucket_txs_params) do
    case Buckets.update_bucket_txs(socket.assigns.bucket_txs, bucket_txs_params) do
      {:ok, _bucket_txs} ->
        {:noreply,
         socket
         |> put_flash(:info, "Bucket txs updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_bucket_txs(socket, :new, bucket_txs_params) do
    case BucketsDomain.create_new_bucket_transaccion(bucket_txs_params) do
      {:ok, _bucket_txs} ->
        {:noreply,
         socket
         |> put_flash(:info, "Bucket txs created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        IO.inspect(changeset)
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
