defmodule Core.Repo.Migrations.CreateUtxio do
  use Ecto.Migration

  def change do
    create table(:utxio, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :object_id, :string
      add :tx_reference_id, :string
      add :size, :decimal
      add :assetmedio, :string

      timestamps()
    end
  end
end
