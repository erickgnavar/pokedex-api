defmodule Pokedex.Pokemon do
  use Ecto.Schema
  import Ecto.Changeset

  @timestamps_opts [type: :utc_datetime_usec]

  @fields [
    :attack,
    :defense,
    :hp,
    :image_url,
    :name,
    :number,
    :speed,
    :speed_attack,
    :speed_defense,
    :total,
    :types
  ]

  schema "pokemons" do
    field(:attack, :integer)
    field(:defense, :integer)
    field(:hp, :integer)
    field(:image_url, :string)
    field(:name, :string)
    field(:number, :integer)
    field(:speed, :integer)
    field(:speed_attack, :integer)
    field(:speed_defense, :integer)
    field(:total, :integer)
    field(:types, {:array, :string})

    timestamps()
  end

  def create_changeset(attrs) do
    %__MODULE__{}
    |> cast(attrs, @fields)
    |> validate_required(@fields)
  end
end
