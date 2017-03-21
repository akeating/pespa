defmodule Edge.Web.ErrorViewTest do
  use Edge.Web.ConnCase, async: true

  # Bring render/3 and render_to_string/3 for testing custom views
  import Phoenix.View

  test "renders 404.json" do
    assert render_to_string(Edge.Web.ErrorView, "404.json", []) ==
      "{\"error\":\"Not found\"}"
  end

  test "render 500.json" do
    assert render_to_string(Edge.Web.ErrorView, "500.json", []) ==
      "{\"error\":\"Server error\"}"
  end

  test "render any other" do
    assert render_to_string(Edge.Web.ErrorView, "505.json", []) ==
      "{\"error\":\"Server error\"}"
  end
end
