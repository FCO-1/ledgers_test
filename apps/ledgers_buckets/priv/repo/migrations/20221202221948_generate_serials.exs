defmodule LedgersBuckets.Repo.Migrations.GenerateSerials do
  use Ecto.Migration

  def change do
    schema = "buckets"
    execute "CREATE SEQUENCE #{schema}.bucket_txs_sequence start with 1000;", "DROP SEQUENCE IF EXISTS #{schema}.bucket_txs_sequence;"
    execute "CREATE SEQUENCE #{schema}.bucket_tx_from_sequence start with 1000;", "DROP SEQUENCE IF EXISTS #{schema}.bucket_tx_from_sequence;"
    execute "CREATE SEQUENCE #{schema}.bucket_tx_to_sequence start with 1000;", "DROP SEQUENCE IF EXISTS #{schema}.bucket_tx_to_sequence;"
    execute "CREATE SEQUENCE #{schema}.bucket_sequence start with 1000;", "DROP SEQUENCE IF EXISTS #{schema}.bucket_sequence;"
    execute "CREATE SEQUENCE #{schema}.bucket_flow_sequence start with 1000;", "DROP SEQUENCE IF EXISTS #{schema}.bucket_flow_sequence;"
  end
end
