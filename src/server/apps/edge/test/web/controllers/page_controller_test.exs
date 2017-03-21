defmodule Edge.Web.PageControllerTest do
  use Edge.Web.ConnCase

  test "GET /", %{conn: conn} do
    conn = get conn, "/"
    assert json_response(conn, 404) == %{"error" => "Not found"}
  end
end
