defmodule LedgersBucketsWeb.BucketTxsLive.Index do
  use LedgersBucketsWeb, :live_view

  alias EdgeGateeay.Api.BucketsApex
  alias LedgersBuckets.Buckets.BucketTxs

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :bucket_txs_collection, list_bucket_txs())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Bucket txs")
    |> assign(:bucket_txs, BucketsApex.get_bucket_txs!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Bucket txs")
    |> assign(:bucket_txs, %BucketTxs{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Bucket txs")
    |> assign(:bucket_txs, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    bucket_txs = BucketsApex.get_bucket_txs!(id)
    {:ok, _} = BucketsApex.delete_bucket_txs(bucket_txs)

    {:noreply, assign(socket, :bucket_txs_collection, list_bucket_txs())}
  end


  def handle_event("confirm_clent_recive", _params, socket) do
    {:noreply, socket}
  end

  defp list_bucket_txs do
    BucketsApex.list_bucket_txs()
  end
end
