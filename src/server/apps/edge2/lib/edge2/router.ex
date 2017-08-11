defmodule Edge2.Router do
  use Edge2, :router

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

  pipeline :with_token do
    # Looks for a token in the Authorization header. If one is not found, this does nothing.
    plug Guardian.Plug.VerifyHeader

    # Looks for a previously verified token. If one is found, continues, otherwise
    # it will call the :unauthenticated function of Guardian.Plug.ErrorHandlers or your provided handler.
    plug Guardian.Plug.EnsureAuthenticated

    # Fetches the resource from the Serializer and makes it available via Guardian.Plug.current_resource(conn)
    # Returns nil if no resource found
    plug Guardian.Plug.LoadResource
  end

  pipeline :graphql do
    plug Edge2.Plug.Context
  end

  scope "/api", Edge2 do
    pipe_through :api
    post "/token", ApiController, :exchange_credentials_for_token
  end

  # routes that must be authenticated
  scope "/api" do
    pipe_through :api
    pipe_through :with_token

    scope "/graphql" do
      pipe_through :graphql
      forward "/", Absinthe.Plug, schema: Edge2.Graphql.Schema
    end
  end

  scope "/", Edge2 do
    get "/*path", ApiController, :not_found
  end
end
