defmodule Orders.BucketTableLive.Index do
  use Orders, :live_view

  alias Core.Buckets
  alias Core.Buckets.BucketTable

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :bucket_table_collection, list_bucket_table())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Bucket table")
    |> assign(:bucket_table, Buckets.get_bucket_table!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Bucket table")
    |> assign(:bucket_table, %BucketTable{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Bucket table")
    |> assign(:bucket_table, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    bucket_table = Buckets.get_bucket_table!(id)
    {:ok, _} = Buckets.delete_bucket_table(bucket_table)

    {:noreply, assign(socket, :bucket_table_collection, list_bucket_table())}
  end

  defp list_bucket_table do
    Buckets.list_bucket_table()
  end
end
