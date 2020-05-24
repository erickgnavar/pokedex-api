import Config

config :pokedex, Pokedex.Repo,
  username: "postgres",
  password: "postgres",
  database: "pokedex_test#{System.get_env("MIX_TEST_PARTITION")}",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
