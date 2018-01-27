defmodule Edge.Router do
  use Edge, :router

  pipeline :api do
    plug :put_format, :json
    plug Plug.RequestId
    plug Plug.Logger

    plug Plug.Parsers,
      parsers: [:urlencoded, :multipart, :json],
      pass: ["*/*"],
      json_decoder: Poison

    plug Plug.MethodOverride
    plug Plug.Head
  end

  pipeline :graphql do
    plug Edge.Plug.Context
  end

  scope "/api" do
    pipe_through :api
    pipe_through Edge.AuthAccessPipeline

    scope "/graphql" do
      pipe_through :graphql
      forward "/", Absinthe.Plug, schema: Edge.Graphql.Schema
    end
  end

  scope "/", Edge do
    get "/*path", ApiController, :not_found
  end
end
