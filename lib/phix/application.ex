defmodule Phix.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      PhixWeb.Telemetry,
      # Start the Ecto repository
      Phix.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: Phix.PubSub},
      # Start Finch
      {Finch, name: Phix.Finch},
      # Start the Endpoint (http/https)
      PhixWeb.Endpoint
      # Start a worker by calling: Phix.Worker.start_link(arg)
      # {Phix.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Phix.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    PhixWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
