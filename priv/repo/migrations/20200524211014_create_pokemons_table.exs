defmodule Pokedex.Repo.Migrations.CreatePokemonsTable do
  use Ecto.Migration

  def change do
    create table(:pokemons) do
      add :attack, :integer, null: false
      add :defense, :integer, null: false
      add :hp, :integer, null: false
      add :image_url, :string, null: false
      add :name, :string, null: false
      add :number, :integer, null: false
      add :speed, :integer, null: false
      add :speed_attack, :integer, null: false
      add :speed_defense, :integer, null: false
      add :total, :integer, null: false
      add :types, {:array, :string}

      timestamps()
    end
  end
end
