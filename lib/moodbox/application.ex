defmodule Moodbox.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      MoodboxWeb.Telemetry,
      # Start the Ecto repository
      Moodbox.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: Moodbox.PubSub},
      # Start Finch
      {Finch, name: Moodbox.Finch},
      # Start the Endpoint (http/https)
      MoodboxWeb.Endpoint
      # Start a worker by calling: Moodbox.Worker.start_link(arg)
      # {Moodbox.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Moodbox.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    MoodboxWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
