defmodule ShopWeb.CatControllerTest do
  use ShopWeb.ConnCase

  test "GET /cats", %{conn: conn} do
    conn = get(conn, "/cats")
    assert html_response(conn, 200) =~ "Fotos de Gatinhos"
  end
end
