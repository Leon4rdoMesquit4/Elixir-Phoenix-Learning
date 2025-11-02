defmodule ShopWeb.BlogController do
  use ShopWeb, :controller

  def index(conn, _params) do
    # dbg(params)
    render(conn, :index)
  end
end
