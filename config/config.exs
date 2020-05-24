import Config

config :pokedex, ecto_repos: [Pokedex.Repo]

import_config "#{Mix.env()}.exs"
