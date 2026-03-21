defmodule Automaton.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      AutomatonWeb.Telemetry,
      {DNSCluster, query: Application.get_env(:automaton, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Automaton.PubSub},
      # Start a worker by calling: Automaton.Worker.start_link(arg)
      # {Automaton.Worker, arg},
      # Start to serve requests, typically the last entry
      AutomatonWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Automaton.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    AutomatonWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
