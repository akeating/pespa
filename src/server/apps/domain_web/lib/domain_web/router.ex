defmodule DomainWeb.Router do
  use DomainWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :graphql do
    plug :accepts, ["json"]
    plug DomainWeb.Plug.Context
  end

  scope "/api" do
    pipe_through :api
    pipe_through DomainWeb.AuthAccessPipeline

    scope "/graphql" do
      pipe_through :graphql
      forward "/", Absinthe.Plug, schema: DomainWeb.Graphql.Schema
    end
  end

  scope "/", DomainWeb do
    get "/*path", ApiController, :not_found
  end
end
