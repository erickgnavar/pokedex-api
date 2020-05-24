defmodule Pokedex.Storage do
  @moduledoc """
  Module to interact with the database
  """

  alias Pokedex.Pokemon
  alias Pokedex.Repo
  import Ecto.Query

  def list_all do
    Repo.all(Pokemon)
  end

  @spec lookup(String.t()) :: [Pokemon.t()]
  def lookup(term) do
    q = "%#{term}%"

    Pokemon
    |> where([p], ilike(p.name, ^q))
    |> Repo.all()
  end
end
