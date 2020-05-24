defmodule Pokedex.Loader do
  @moduledoc """
  Module to load data to database
  """

  alias Pokedex.{Spider, Pokemon, Repo}
  require Logger

  def fetch_and_insert_data do
    with {:ok, items} <- Spider.get_all() do
      items
      |> Enum.map(&Pokemon.create_changeset/1)
      |> Enum.each(&Repo.insert/1)
    else
      error ->
        Logger.error("Something happened :( -> #{inspect(error)}")
    end
  end
end
