defmodule LedgersBucketsWeb.PersonLive.Index do
  use LedgersBucketsWeb, :live_view

  alias Core.Persons
  alias Core.Persons.Person

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :persons, list_persons())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Person")
    |> assign(:person, Persons.get_person!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Person")
    |> assign(:person, %Person{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Persons")
    |> assign(:person, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    person = Persons.get_person!(id)
    {:ok, _} = Persons.delete_person(person)

    {:noreply, assign(socket, :persons, list_persons())}
  end

  defp list_persons do
    Persons.list_persons()
  end
end
