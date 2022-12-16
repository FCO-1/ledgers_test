defmodule Core.PersonsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Core.Persons` context.
  """

  @doc """
  Generate a person.
  """
  def person_fixture(attrs \\ %{}) do
    {:ok, person} =
      attrs
      |> Enum.into(%{
        alias: "some alias",
        name: "some name"
      })
      |> Core.Persons.create_person()

    person
  end
end
