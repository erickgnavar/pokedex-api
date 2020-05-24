defmodule Pokedex.Spider do
  @moduledoc """
  Fetch data from https://pokemondb.net
  """

  @all_url "https://pokemondb.net/pokedex/all"

  @headers [
    "number",
    "name",
    "type",
    "total",
    "hp",
    "attack",
    "defense",
    "speed_attack",
    "speed_defense",
    "speed"
  ]

  @spec get_all :: [map]
  def get_all do
    with {:ok, raw_data} <- fetch_html(@all_url) do
      parse_html(raw_data)
    end
  end

  defp fetch_html(url) do
    case Mojito.get(url) do
      {:ok, %{status_code: 200, body: body}} ->
        {:ok, body}

      {:error, reason} ->
        {:error, reason}
    end
  end

  @spec parse_html(String.t()) :: [map]
  defp parse_html(html) do
    {:ok, doc} = Floki.parse_document(html)
    [{_name, _attrs, [_thead, tbody]}] = Floki.find(doc, "#pokedex")

    items =
      tbody
      |> Floki.children()
      |> Enum.map(&extract_data_from_row/1)
      |> Enum.map(&(Enum.zip(@headers, &1) |> Map.new()))
      |> Enum.map(&fix_type/1)
      |> Enum.map(&put_image_url/1)

    {:ok, items}
  end

  defp extract_data_from_row(row) do
    row
    |> Floki.children()
    |> Enum.map(&Floki.text/1)
  end

  defp fix_type(data) do
    type =
      data
      |> Map.get("type")
      |> String.trim()
      |> String.split("\n")
      |> Enum.reject(&(&1 == ""))

    Map.put(data, "type", type)
  end

  @spec put_image_url(map) :: String.t()
  defp put_image_url(%{"name" => name} = data) do
    Map.put(
      data,
      "image_url",
      "https://img.pokemondb.net/artwork/large/#{String.downcase(name)}.jpg"
    )
  end
end
