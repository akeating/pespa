defmodule Edge.Application do
  use Application

  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    import Supervisor.Spec

    # Define workers and child supervisors to be supervised
    children = [
      supervisor(Edge.Repo, []),
      supervisor(Edge.Web.Endpoint, []),
      # Start your own worker by calling: Edge.Worker.start_link(arg1, arg2, arg3)
      # worker(Edge.Worker, [arg1, arg2, arg3]),
    ]

    # See http://elixir-lang.org/docs/stable/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Edge.Supervisor]
    Supervisor.start_link(children, opts)
  end

end
