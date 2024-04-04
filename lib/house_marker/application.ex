defmodule HouseMarker.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      HouseMarker.App,
      HouseMarker.Houses.Supervisor,
      HouseMarkerWeb.Telemetry,
      HouseMarker.Repo,
      {DNSCluster, query: Application.get_env(:house_marker, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: HouseMarker.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: HouseMarker.Finch},
      # Start a worker by calling: HouseMarker.Worker.start_link(arg)
      # {HouseMarker.Worker, arg},
      # Start to serve requests, typically the last entry
      HouseMarkerWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: HouseMarker.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    HouseMarkerWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
