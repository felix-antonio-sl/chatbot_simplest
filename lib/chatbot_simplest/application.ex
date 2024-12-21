defmodule ChatbotSimplest.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      ChatbotSimplestWeb.Telemetry,
      ChatbotSimplest.Repo,
      {DNSCluster, query: Application.get_env(:chatbot_simplest, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: ChatbotSimplest.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: ChatbotSimplest.Finch},
      # Start a worker by calling: ChatbotSimplest.Worker.start_link(arg)
      # {ChatbotSimplest.Worker, arg},
      # Start to serve requests, typically the last entry
      ChatbotSimplestWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: ChatbotSimplest.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    ChatbotSimplestWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
