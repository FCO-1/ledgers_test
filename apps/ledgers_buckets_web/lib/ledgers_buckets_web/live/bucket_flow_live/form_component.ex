defmodule LedgersBucketsWeb.BucketFlowLive.FormComponent do
  use LedgersBucketsWeb, :live_component

  alias LedgersBuckets.Buckets

  @impl true
  def update(%{bucket_flow: bucket_flow} = assigns, socket) do
    changeset = Buckets.change_bucket_flow(bucket_flow)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"bucket_flow" => bucket_flow_params}, socket) do
    changeset =
      socket.assigns.bucket_flow
      |> Buckets.change_bucket_flow(bucket_flow_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"bucket_flow" => bucket_flow_params}, socket) do
    save_bucket_flow(socket, socket.assigns.action, bucket_flow_params)
  end

  defp save_bucket_flow(socket, :edit, bucket_flow_params) do
    case Buckets.update_bucket_flow(socket.assigns.bucket_flow, bucket_flow_params) do
      {:ok, _bucket_flow} ->
        {:noreply,
         socket
         |> put_flash(:info, "Bucket flow updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_bucket_flow(socket, :new, bucket_flow_params) do
    case Buckets.create_bucket_flow(bucket_flow_params) do
      {:ok, _bucket_flow} ->
        {:noreply,
         socket
         |> put_flash(:info, "Bucket flow created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
