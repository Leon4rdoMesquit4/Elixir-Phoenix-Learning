defmodule ShopWeb.SEO do
  use ShopWeb, :verified_routes

  use SEO, [
    json_library: Jason,
    site: &__MODULE__.site_config/1
  ]

  def site_config(_conn) do
    SEO.Site.build(
      default_title: "Default Title",
      description: "A blog about development"
    )
  end
end
