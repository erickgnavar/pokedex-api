defmodule PokedexWeb.Router do
  use Plug.Router

  plug(Plug.Logger)
  plug(Plug.RequestId)
  plug(:match)
  plug(:dispatch)

  alias Pokedex.Storage

  get "/pokemons/" do
    %{query_params: params} = Plug.Conn.fetch_query_params(conn)

    pokemons =
      case Map.get(params, "q", "") do
        "" ->
          Storage.list_all()

        query ->
          Storage.lookup(query)
      end

    response =
      pokemons
      |> Enum.map(&Jason.encode!/1)

    send_resp(conn, 200, response)
  end

  match _ do
    send_resp(conn, 404, "oops")
  end
end
