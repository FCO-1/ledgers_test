defmodule LedgersBucketsWeb.OrderBucketTxsLive.Index do
  use LedgersBucketsWeb, :live_view

  alias LedgersBuckets.Orders
  alias LedgersBuckets.Orders.OrderBucketTxs

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :order_bucket_txs_collection, list_order_bucket_txs())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Order bucket txs")
    |> assign(:order_bucket_txs, Orders.get_order_bucket_txs!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Order bucket txs")
    |> assign(:order_bucket_txs, %OrderBucketTxs{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Order bucket txs")
    |> assign(:order_bucket_txs, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    order_bucket_txs = Orders.get_order_bucket_txs!(id)
    {:ok, _} = Orders.delete_order_bucket_txs(order_bucket_txs)

    {:noreply, assign(socket, :order_bucket_txs_collection, list_order_bucket_txs())}
  end

  defp list_order_bucket_txs do
    Orders.list_order_bucket_txs()
  end
end
