defmodule PokedexWeb.Router do
  use Plug.Router

  require EEx
  EEx.function_from_file(:defp, :home_view, "lib/pokedex_web/templates/home.txt.eex", [])

  plug(Plug.Logger)
  plug(Plug.RequestId)
  plug(:match)
  plug(:dispatch)

  alias Pokedex.Storage

  get "/" do
    content = home_view()

    conn
    |> put_resp_content_type("text/plain")
    |> send_resp(200, content)
  end

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

    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, response)
  end

  match _ do
    send_resp(conn, 404, "oops")
  end
end
