defmodule DomainWeb.Plug.Context do
  @moduledoc """
  """
  import Plug.Conn

  def init(opts), do: opts

  def call(conn, _opts) do
    case Guardian.Plug.current_resource(conn) do
      # Here user could be nil or Domain.Accounts.User
      user -> put_private(conn, :absinthe, %{context: %{current_user: user}})
    end
  end
end
