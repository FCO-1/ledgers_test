defmodule LedgersBuckets.Repo do
  use Ecto.Repo,
    otp_app: :ledgers_buckets,
    adapter: Ecto.Adapters.Postgres
end
