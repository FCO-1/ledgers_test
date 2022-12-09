defmodule LedgersBucketsWeb.BucketTxToLive.Index do
  use LedgersBucketsWeb, :live_view

  alias EdgeGateeay.Api.BucketsApex
  alias LedgersBuckets.Buckets.BucketTxTo

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :bucket_tx_to_collection, list_bucket_tx_to())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Bucket tx to")
    |> assign(:bucket_tx_to, BucketsApex.get_bucket_tx_to!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Bucket tx to")
    |> assign(:bucket_tx_to, %BucketTxTo{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Bucket tx to")
    |> assign(:bucket_tx_to, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    bucket_tx_to = BucketsApex.get_bucket_tx_to!(id)
    {:ok, _} = BucketsApex.delete_bucket_tx_to(bucket_tx_to)

    {:noreply, assign(socket, :bucket_tx_to_collection, list_bucket_tx_to())}
  end

  defp list_bucket_tx_to do
    BucketsApex.list_bucket_tx_to()
  end
end
