defmodule Orders.UtxioLive.FormComponent do
  use Orders, :live_component

  alias Core.Transactions

  @impl true
  def update(%{utxio: utxio} = assigns, socket) do
    changeset = Transactions.change_utxio(utxio)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"utxio" => utxio_params}, socket) do
    changeset =
      socket.assigns.utxio
      |> Transactions.change_utxio(utxio_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"utxio" => utxio_params}, socket) do
    save_utxio(socket, socket.assigns.action, utxio_params)
  end

  defp save_utxio(socket, :edit, utxio_params) do
    case Transactions.update_utxio(socket.assigns.utxio, utxio_params) do
      {:ok, _utxio} ->
        {:noreply,
         socket
         |> put_flash(:info, "Utxio updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_utxio(socket, :new, utxio_params) do
    case Transactions.create_tx(utxio_params) do
      {:ok, _utxio} ->
        {:noreply,
         socket
         |> put_flash(:info, "Utxio created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        IO.inspect(changeset)
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
