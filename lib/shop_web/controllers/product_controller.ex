defmodule ShopWeb.ProductController do
  use ShopWeb, :controller
  alias Shop.{Product, Repo}

  def index(conn, _params) do
    # dbg(params)

    products = Repo.all(Product)

    conn
    |> SEO.assign(%{
      title: "Products",
      description: "Browse our product catalog"
    })
    |> render(:index, products: products)
  end

  def show(conn, %{"slug" => slug}) do
    product = Repo.get_by!(Product, slug: slug)

    conn
    |> SEO.assign(%{
      title: product.name,
      description: "Details for #{product.name}"
    })
    |> render(:show, product: product)
  end
end