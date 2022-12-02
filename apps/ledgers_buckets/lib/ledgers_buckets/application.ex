defmodule LedgersBuckets.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      LedgersBuckets.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: LedgersBuckets.PubSub}
      # Start a worker by calling: LedgersBuckets.Worker.start_link(arg)
      # {LedgersBuckets.Worker, arg}
    ]

    Supervisor.start_link(children, strategy: :one_for_one, name: LedgersBuckets.Supervisor)
  end
end
