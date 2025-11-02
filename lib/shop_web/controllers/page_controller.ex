defmodule ShopWeb.PageController do
  use ShopWeb, :controller
  alias Shop.StrapiClient
  import Shop.RichTextToHtml

  def home(conn, _params) do
    {:ok, response} = StrapiClient.get("/posts")
    decoded = Jason.decode!(response.body)
    posts = decoded["data"]
    post = Enum.at(posts, -1)

    IO.inspect(post["conteudo"], label: "CONTEUDO")
    conteudo_html = to_html(post["conteudo"])
    IO.inspect(conteudo_html, label: "CONTEUDO HTML")

    render(conn, :home, posts: posts, conteudo_html: conteudo_html)
  end
end
