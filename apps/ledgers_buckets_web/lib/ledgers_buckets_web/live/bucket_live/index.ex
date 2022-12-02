defmodule LedgersBucketsWeb.BucketLive.Index do
  use LedgersBucketsWeb, :live_view

  alias LedgersBuckets.Buckets
  alias LedgersBuckets.Buckets.Bucket

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :buckets, list_buckets())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Bucket")
    |> assign(:bucket, Buckets.get_bucket!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Bucket")
    |> assign(:bucket, %Bucket{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Buckets")
    |> assign(:bucket, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    bucket = Buckets.get_bucket!(id)
    {:ok, _} = Buckets.delete_bucket(bucket)

    {:noreply, assign(socket, :buckets, list_buckets())}
  end

  defp list_buckets do
    Buckets.list_buckets()
  end
end
