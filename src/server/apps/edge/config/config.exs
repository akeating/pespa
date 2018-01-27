# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :edge,
  namespace: Edge,
  ecto_repos: [Domain.Repo]

# Configures the endpoint
config :edge, Edge.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "0a3NTAoCx42l3WJTLMu2JaqXMCmzML69/ypWI/1pYQ1rHpquiXwMx3ZmhD4nUK08",
  render_errors: [view: Edge.ErrorView, accepts: ~w(json)],
  pubsub: [name: Edge.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :edge, :generators,
  context_app: false

config :edge, Edge.Guardian,
  allowed_algos: ["HS512"], # optional
  verify_module: Guardian.JWT,  # optional
  issuer: "pespa",
  ttl: { 1, :days },
  verify_issuer: true, # optional
  secret_key: "whateverz"

config :edge, Edge.AuthAccessPipeline,
  module: Edge.Guardian,
  error_handler: Edge.AuthErrorHandler
    
# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
