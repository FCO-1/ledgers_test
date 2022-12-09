defmodule LedgersBucketsWeb.BucketTxFromLive.Show do
  use LedgersBucketsWeb, :live_view

  alias EdgeGateeay.Api.BucketsApex
  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:bucket_tx_from, BucketsApex.get_bucket_tx_from!(id))}
  end

  defp page_title(:show), do: "Show Bucket tx from"
  defp page_title(:edit), do: "Edit Bucket tx from"
end
