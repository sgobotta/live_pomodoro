defmodule LivePomodoro.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      LivePomodoroWeb.Telemetry,
      LivePomodoro.Repo,
      {DNSCluster,
       query:
         Application.get_env(
           :live_pomodoro,
           :dns_cluster_query
         ) || :ignore},
      {Phoenix.PubSub, name: LivePomodoro.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: LivePomodoro.Finch},
      # Start a worker by calling: LivePomodoro.Worker.start_link(arg)
      # {LivePomodoro.Worker, arg},
      # Start to serve requests, typically the last entry
      LivePomodoroWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: LivePomodoro.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    LivePomodoroWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
