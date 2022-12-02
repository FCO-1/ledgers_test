defmodule LedgersBucketsWeb.BucketLive.Show do
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
     |> assign(:bucket, Buckets.get_bucket!(id))}
  end

  defp page_title(:show), do: "Show Bucket"
  defp page_title(:edit), do: "Edit Bucket"
end
