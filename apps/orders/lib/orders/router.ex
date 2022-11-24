defmodule Orders.Router do
  use Orders, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {Orders.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Orders do
    pipe_through :browser

    get "/", PageController, :index

    live "/tx_tests", TxTestLive.Index, :index
    live "/tx_tests/new", TxTestLive.Index, :new
    live "/tx_tests/:id/edit", TxTestLive.Index, :edit

    live "/tx_tests/:id", TxTestLive.Show, :show
    live "/tx_tests/:id/show/edit", TxTestLive.Show, :edit

    live "/utxio", UtxioLive.Index, :index
    live "/utxio/new", UtxioLive.Index, :new
    live "/utxio/:id/edit", UtxioLive.Index, :edit

    live "/utxio/:id", UtxioLive.Show, :show
    live "/utxio/:id/show/edit", UtxioLive.Show, :edit
  end

  # Other scopes may use custom stacks.
  # scope "/api", Orders do
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

      live_dashboard "/dashboard", metrics: Orders.Telemetry
    end
  end
end
