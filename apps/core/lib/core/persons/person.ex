defmodule Core.Persons.Person do
  use Ecto.Schema
  import Ecto.Changeset

  @schema_prefix "persons"
  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "persons" do
    field :alias, :string
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(person, attrs) do
    person
    |> cast(attrs, [:alias, :name])
    |> validate_required([:alias, :name])
  end
end
