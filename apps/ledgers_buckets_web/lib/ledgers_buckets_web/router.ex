defmodule LedgersBucketsWeb.Router do
  use LedgersBucketsWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {LedgersBucketsWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", LedgersBucketsWeb do
    pipe_through :browser

    get "/", PageController, :index

    live "/persons", PersonLive.Index, :index
    live "/persons/new", PersonLive.Index, :new
    live "/persons/:id/edit", PersonLive.Index, :edit

    live "/persons/:id", PersonLive.Show, :show
    live "/persons/:id/show/edit", PersonLive.Show, :edit

    live "/wallets", WalletLive.Index, :index
    live "/wallets/new", WalletLive.Index, :new
    live "/wallets/:id/edit", WalletLive.Index, :edit

    live "/wallets/:id", WalletLive.Show, :show
    live "/wallets/:id/show/edit", WalletLive.Show, :edit

    live "/orders", OrderLive.Index, :index
    live "/orders/new", OrderLive.Index, :new
    live "/orders/:id/edit", OrderLive.Index, :edit

    live "/orders/:id", OrderLive.Show, :show
    live "/orders/:id/show/edit", OrderLive.Show, :edit

    live "/bucket_txs", BucketTxsLive.Index, :index
    live "/bucket_txs/new", BucketTxsLive.Index, :new
    live "/bucket_txs/:id/edit", BucketTxsLive.Index, :edit

    live "/bucket_txs/:id", BucketTxsLive.Show, :show
    live "/bucket_txs/:id/show/edit", BucketTxsLive.Show, :edit

    live "/bucket_tx_from", BucketTxFromLive.Index, :index
    live "/bucket_tx_from/new", BucketTxFromLive.Index, :new
    live "/bucket_tx_from/:id/edit", BucketTxFromLive.Index, :edit

    live "/bucket_tx_from/:id", BucketTxFromLive.Show, :show
    live "/bucket_tx_from/:id/show/edit", BucketTxFromLive.Show, :edit

    live "/bucket_tx_to", BucketTxToLive.Index, :index
    live "/bucket_tx_to/new", BucketTxToLive.Index, :new
    live "/bucket_tx_to/:id/edit", BucketTxToLive.Index, :edit

    live "/bucket_tx_to/:id", BucketTxToLive.Show, :show
    live "/bucket_tx_to/:id/show/edit", BucketTxToLive.Show, :edit

    live "/buckets", BucketLive.Index, :index
    live "/buckets/new", BucketLive.Index, :new
    live "/buckets/:id/edit", BucketLive.Index, :edit

    live "/buckets/:id", BucketLive.Show, :show
    live "/buckets/:id/show/edit", BucketLive.Show, :edit

    live "/bucket_flows", BucketFlowLive.Index, :index
    live "/bucket_flows/new", BucketFlowLive.Index, :new
    live "/bucket_flows/:id/edit", BucketFlowLive.Index, :edit

    live "/bucket_flows/:id", BucketFlowLive.Show, :show
    live "/bucket_flows/:id/show/edit", BucketFlowLive.Show, :edit
  end

  # Other scopes may use custom stacks.
  # scope "/api", LedgersBucketsWeb do
  #   pipe_through :api
  # end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: LedgersBucketsWeb.Telemetry
    end
  end
end
