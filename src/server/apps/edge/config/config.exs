# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# Configures the endpoint
config :edge, Edge.Web.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "jyk1DniIrJ6XVeH7tg0yPw8QcuTzhxgQiHW5luFt0nIRC2LUuc3YWvcs+sHRW3M7",
  render_errors: [view: Edge.Web.ErrorView, accepts: ~w(json), format: "json"],
  pubsub: [name: Edge.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :guardian, Guardian,
  allowed_algos: ["HS512"], # optional
  verify_module: Guardian.JWT,  # optional
  issuer: "Edge",
  ttl: { 1, :days },
  verify_issuer: true, # optional
  secret_key: "whateverz",
  serializer: Edge.GuardianSerializer

config :edge, ecto_repos: [Edge.Repo]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
