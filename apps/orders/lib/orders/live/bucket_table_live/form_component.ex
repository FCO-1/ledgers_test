defmodule Orders.BucketTableLive.FormComponent do
  use Orders, :live_component

  alias Core.Buckets

  @impl true
  def update(%{bucket_table: bucket_table} = assigns, socket) do
    changeset = Buckets.change_bucket_table(bucket_table)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"bucket_table" => bucket_table_params}, socket) do
    changeset =
      socket.assigns.bucket_table
      |> Buckets.change_bucket_table(bucket_table_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"bucket_table" => bucket_table_params}, socket) do
    save_bucket_table(socket, socket.assigns.action, bucket_table_params)
  end

  defp save_bucket_table(socket, :edit, bucket_table_params) do
    case Buckets.update_bucket_table(socket.assigns.bucket_table, bucket_table_params) do
      {:ok, _bucket_table} ->
        {:noreply,
         socket
         |> put_flash(:info, "Bucket table updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_bucket_table(socket, :new, bucket_table_params) do
    case Buckets.create_bucket_table(bucket_table_params) do
      {:ok, _bucket_table} ->
        {:noreply,
         socket
         |> put_flash(:info, "Bucket table created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
