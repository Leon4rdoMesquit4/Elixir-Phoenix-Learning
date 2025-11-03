defmodule ShopWeb.ProductController do
  use ShopWeb, :controller
  alias Shop.StrapiClient

  def index(conn, _params) do
    # dbg(params)

    conn
    |> SEO.assign(%{
      title: "Products",
      description: "Browse our product catalog"
    })
    |> render(:index)
  end

end
