defmodule ShopWeb.ProductController do
  use ShopWeb, :controller
  alias Shop.StrapiClient

  def index(conn, _params) do
    # dbg(params)

    render(conn, :index)
  end

end
