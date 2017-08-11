use Mix.Config

config :domain, ecto_repos: [Domain.Repo]

import_config "#{Mix.env}.exs"
