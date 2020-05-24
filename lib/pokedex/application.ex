defmodule Pokedex.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Starts a worker by calling: Pokedex.Worker.start_link(arg)
      # {Pokedex.Worker, arg}
      Pokedex.Repo,
      # TODO: make port configurable
      {Plug.Cowboy, scheme: :http, plug: PokedexWeb.Router, options: [port: 4000]}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Pokedex.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
