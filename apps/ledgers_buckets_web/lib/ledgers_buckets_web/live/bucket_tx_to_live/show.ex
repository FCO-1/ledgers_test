defmodule LedgersBucketsWeb.BucketTxToLive.Show do
  use LedgersBucketsWeb, :live_view

  alias LedgersBuckets.Buckets

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:bucket_tx_to, Buckets.get_bucket_tx_to!(id))}
  end

  defp page_title(:show), do: "Show Bucket tx to"
  defp page_title(:edit), do: "Edit Bucket tx to"
end
