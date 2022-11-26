defmodule Orders.BucketTableLive.Show do
  use Orders, :live_view

  alias Core.Buckets

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:bucket_table, Buckets.get_bucket_table!(id))}
  end

  defp page_title(:show), do: "Show Bucket table"
  defp page_title(:edit), do: "Edit Bucket table"
end
