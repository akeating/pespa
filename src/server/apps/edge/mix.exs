defmodule Edge.Mixfile do
  use Mix.Project

  def project do
    [app: :edge,
     version: "0.0.1",
     build_path: "../../_build",
     config_path: "../../config/config.exs",
     deps_path: "../../deps",
     lockfile: "../../mix.lock",
     elixir: "~> 1.4",
     elixirc_paths: elixirc_paths(Mix.env),
     compilers: [:phoenix, :gettext] ++ Mix.compilers,
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps(),
     aliases: aliases()]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [mod: {Edge.Application, []},
     extra_applications: [:logger]]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "web", "test/support"]
  defp elixirc_paths(_),     do: ["lib", "web"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
      {:absinthe_plug, "~> 1.2.3"},
      {:comeonin, "~> 3.0"},
      {:cowboy, "~> 1.0"},
      {:gettext, "~> 0.11"},
      {:guardian, "~> 0.14"},
      {:phoenix, "~> 1.2.1"},
      {:phoenix_pubsub, "~> 1.0"},
      {:phoenix_ecto, "~> 3.2"},
      {:postgrex, ">= 0.0.0"},
    ]
  end

  defp aliases do
    seeds = __DIR__ <> "/priv/repo/seeds.exs"
    [
      "seed": ["run " <> seeds],
      "ecto.setup": ["ecto.create", "ecto.migrate --quiet", "seed"],
      "ecto.reset": ["ecto.drop", "ecto.setup"],
      "test": ["ecto.reset --quiet", "ecto.migrate", "test"]
    ]
  end

end
