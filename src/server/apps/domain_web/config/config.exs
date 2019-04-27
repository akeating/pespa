# Since configuration is shared in umbrella projects, this file
# should only configure the :domain_web application itself
# and only for organization purposes. All other config goes to
# the umbrella root.
use Mix.Config

# General application configuration
config :domain_web,
  ecto_repos: [Domain.Repo],
  generators: [context_app: :domain]

# Configures the endpoint
config :domain_web, DomainWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "0a3NTAoCx42l3WJTLMu2JaqXMCmzML69/ypWI/1pYQ1rHpquiXwMx3ZmhD4nUK08",
  render_errors: [view: DomainWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: DomainWeb.PubSub, adapter: Phoenix.PubSub.PG2]

config :domain_web, DomainWeb.Guardian,
  allowed_algos: ["HS512"], # optional
  verify_module: Guardian.JWT,  # optional
  issuer: "pespa",
  ttl: { 1, :days },
  verify_issuer: true, # optional
  secret_key: "whateverz"

config :domain_web, DomainWeb.AuthAccessPipeline,
  module: DomainWeb.Guardian,
  error_handler: DomainWeb.AuthErrorHandler
    
# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
