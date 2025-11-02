defmodule ShopWeb.ProductHTML do
  use ShopWeb, :html

  # def index(assigns) do
  #   ~H"""
  #   <h1>Amooooo</h1>
  #   <p>Pessoas lindas</p>
  #   """
  # end
  embed_templates "product_html/*"
end
