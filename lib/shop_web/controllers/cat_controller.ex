defmodule ShopWeb.CatController do
  use ShopWeb, :controller

  def index(conn, _params) do
    {:ok, response} = Req.get("https://api.thecatapi.com/v1/images/search?limit=20")
    cats = response.body

    render(conn, "index.html", cats: cats, page_title: "Gatinhos")
  end
end
