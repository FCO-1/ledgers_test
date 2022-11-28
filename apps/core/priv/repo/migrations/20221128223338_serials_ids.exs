defmodule Core.Repo.Migrations.SerialsIds do
  use Ecto.Migration

  def change do
    schema = "transactions"

    execute "CREATE SEQUENCE #{schema}.utxio_sequence start with 1000;", "DROP SEQUENCE IF EXISTS #{schema}.utxio_sequence;"
    execute "CREATE SEQUENCE #{schema}.tx_tests_sequence start with 1000;", "DROP SEQUENCE IF EXISTS #{schema}.tx_tests_sequence;"
    execute "CREATE SEQUENCE #{schema}.general_sequence start with 1000;", "DROP SEQUENCE IF EXISTS #{schema}.general_sequence;"
  end
end
