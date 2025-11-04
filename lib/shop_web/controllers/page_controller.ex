defmodule ShopWeb.PageController do
  use ShopWeb, :controller
  alias Shop.StrapiClient
  import Shop.RichTextToHtml

  def home(conn, _params) do
    {:ok, response} = StrapiClient.get("/posts")
    decoded = Jason.decode!(response.body)
    posts = decoded["data"]

    posts =
      Enum.map(posts, fn post ->
        conteudo = post["conteudo"] || []
        html_conteudo = to_html(conteudo)
        Map.put(post, "html_conteudo", html_conteudo)
      end)

    conn
    |> render("home.html", posts: posts)
  end
end
