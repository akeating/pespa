# Since configuration is shared in umbrella projects, this file
# should only configure the :domain application itself
# and only for organization purposes. All other config goes to
# the umbrella root.
use Mix.Config

config :domain,
  ecto_repos: [Domain.Repo]

import_config "#{Mix.env()}.exs"
