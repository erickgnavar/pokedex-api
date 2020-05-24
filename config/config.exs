import Config

config :pokedex, ecto_repos: [Pokedex.Repo]

config :logger, :console, metadata: [:request_id]

import_config "#{Mix.env()}.exs"
