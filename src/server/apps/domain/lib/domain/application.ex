defmodule Domain.Application do
  @moduledoc """
  The Domain Application Service.

  The domain system business domain lives in this application.

  Exposes API to clients such as the `DomainWeb` application
  for use in channels, controllers, and elsewhere.
  """
  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    Supervisor.start_link([
      supervisor(Domain.Repo, []),
      supervisor(Domain.Accounts.Counter, []),
    ], strategy: :one_for_one, name: Domain.Supervisor)
  end
end
