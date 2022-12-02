defmodule LedgersBucketsWeb.BucketFlowLive.Index do
  use LedgersBucketsWeb, :live_view

  alias LedgersBuckets.Buckets
  alias LedgersBuckets.Buckets.BucketFlow

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :bucket_flows, list_bucket_flows())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Bucket flow")
    |> assign(:bucket_flow, Buckets.get_bucket_flow!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Bucket flow")
    |> assign(:bucket_flow, %BucketFlow{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Bucket flows")
    |> assign(:bucket_flow, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    bucket_flow = Buckets.get_bucket_flow!(id)
    {:ok, _} = Buckets.delete_bucket_flow(bucket_flow)

    {:noreply, assign(socket, :bucket_flows, list_bucket_flows())}
  end

  defp list_bucket_flows do
    Buckets.list_bucket_flows()
  end
end
