defmodule Pokedex.Release do
  @moduledoc """
  Run tasks inside releases.
  """
  @app :pokedex

  @doc """
  Run ecto migrations for each repo configured in the application.
  """
  @spec migrate :: any
  def migrate do
    load_app()

    for repo <- repos() do
      {:ok, _, _} = Ecto.Migrator.with_repo(repo, &Ecto.Migrator.run(&1, :up, all: true))
    end
  end

  @doc """
  Run rollback until the given version.
  """
  def rollback(repo, version) do
    load_app()
    {:ok, _, _} = Ecto.Migrator.with_repo(repo, &Ecto.Migrator.run(&1, :down, to: version))
  end

  @doc """
  Fetch data and insert it to database
  """
  def fill_data do
    load_app()
    Application.ensure_all_started(@app)
    Pokedex.Loader.fetch_and_insert_data()
  end

  defp repos do
    Application.fetch_env!(@app, :ecto_repos)
  end

  defp load_app do
    Application.load(@app)
  end
end
