defmodule Edge.Web.ErrorView do

  def render("400.json", _assigns) do
    %{ error: "Bad request" }
  end

  def render("404.json", _assigns) do
    %{ error: "Not found" }
  end

  def render("500.json", _assigns) do
    %{ error: "Server error" }
  end

  def render(_, assigns) do
    render "500.json", assigns
  end

end
