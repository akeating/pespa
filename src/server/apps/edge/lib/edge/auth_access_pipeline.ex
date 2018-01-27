defmodule Edge.AuthAccessPipeline do
  use Guardian.Plug.Pipeline, otp_app: :edge

  # Looks for a token in the Authorization header. If one is not found, this does nothing.
  plug Guardian.Plug.VerifyHeader, claims: %{"typ" => "access"}, realm: :none

  # Following the advice at http://graphql.org/learn/authorization/, authentication is
  # now delegated further into the stack and so this line is disabled.
  # Looks for a previously verified token. If one is found, continues, otherwise
  # it will call the :unauthenticated function of Guardian.Plug.ErrorHandlers or your provided handler.
  # plug Guardian.Plug.EnsureAuthenticated

  # Fetches the resource from the Serializer and makes it available via Guardian.Plug.current_resource(conn)
  # Returns nil if no resource found
  plug Guardian.Plug.LoadResource, allow_blank: true
end