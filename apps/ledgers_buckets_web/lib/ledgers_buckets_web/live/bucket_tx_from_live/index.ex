defmodule LedgersBucketsWeb.BucketTxFromLive.Index do
  use LedgersBucketsWeb, :live_view

  alias EdgeGateeay.Api.BucketsApex
  alias LedgersBuckets.Buckets.BucketTxFrom

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :bucket_tx_from_collection, list_bucket_tx_from())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Bucket tx from")
    |> assign(:bucket_tx_from, BucketsApex.get_bucket_tx_from!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Bucket tx from")
    |> assign(:bucket_tx_from, %BucketTxFrom{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Bucket tx from")
    |> assign(:bucket_tx_from, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    bucket_tx_from = BucketsApex.get_bucket_tx_from!(id)
    {:ok, _} = BucketsApex.delete_bucket_tx_from(bucket_tx_from)

    {:noreply, assign(socket, :bucket_tx_from_collection, list_bucket_tx_from())}
  end

  defp list_bucket_tx_from do
    BucketsApex.list_bucket_tx_from()
  end
end
