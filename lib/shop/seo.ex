defmodule ShopWeb.SEO do
  use ShopWeb, :verified_routes

  use SEO, [
    json_library: Jason,
    # a function reference will be called with a conn during render
    # arity 1 will be passed the conn, arity 0 is also supported.
    site: &__MODULE__.site_config/1,
    open_graph: SEO.OpenGraph.build(
      description: "A blog about development",
      site_name: "My Blog",
      locale: "en_US"
    ),
    facebook: SEO.Facebook.build(app_id: "123")
  ]

  # Or arity 0 is also supported, which can be great if you're using
  # Phoenix verified routes and don't need the conn to generate paths.
  def site_config(conn) do
    SEO.Site.build(
      default_title: "Default Title",
      description: "A blog about development",
      title_suffix: " · My App",
      theme_color: "#663399",
      windows_tile_color: "#663399",
      mask_icon_color: "#663399",
      mask_icon_url: static_url(conn, "/images/safari-pinned-tab.svg"),
      manifest_url: url(conn, ~p"/site.webmanifest")
    )
  end
end
