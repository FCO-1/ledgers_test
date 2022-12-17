# This file is responsible for configuring your umbrella
# and **all applications** and their dependencies with the
# help of the Config module.
#
# Note that all applications in your umbrella share the
# same configuration and dependencies, which is why they
# all use the same configuration file. If you want different
# configurations or dependencies per app, it is best to
# move said applications out of the umbrella.
import Config

config :ledgers_buckets_web,
  ecto_repos: [LedgersBuckets.Repo],
  generators: [context_app: :ledgers_buckets, binary_id: true]

# Configures the endpoint
config :ledgers_buckets_web, LedgersBucketsWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [view: LedgersBucketsWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: LedgersBucketsWeb.PubSub,
  live_view: [signing_salt: "10yW36vB"]

# Configure esbuild (the version is required)
config :esbuild,
  version: "0.14.0",
  ledger_bucket_assets: [
    args:
      ~w(js/app.js --bundle --target=es2017 --outdir=../priv/static/assets --external:/fonts/* --external:/images/*),
    cd: Path.expand("../apps/ledgers_buckets_web/assets", __DIR__),
    env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
  ]

# Configure Mix tasks and generators
config :ledgers_buckets,
  ecto_repos: [LedgersBuckets.Repo]

config :orders,
  ecto_repos: [Core.Repo],
  generators: [context_app: :core, binary_id: true]

# Configures the endpoint
config :orders, Orders.Endpoint,
  url: [host: "localhost"],
  render_errors: [view: Orders.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Orders.PubSub,
  live_view: [signing_salt: "qT2WGTGB"]

# Configure esbuild (the version is required)
config :esbuild,
  version: "0.14.0",
  default: [
    args:
      ~w(js/app.js --bundle --target=es2017 --outdir=../priv/static/assets --external:/fonts/* --external:/images/*),
    cd: Path.expand("../apps/orders/assets", __DIR__),
    env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
  ]

# Configure Mix tasks and generators
config :core,
  ecto_repos: [Core.Repo]

# Sample configuration:
#
#     config :logger, :console,
#       level: :info,
#       format: "$date $time [$level] $metadata$message\n",
#       metadata: [:user_id]
#
# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
