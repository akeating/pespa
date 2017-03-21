defmodule Edge.Web.ApiController do
  use Edge.Web, :controller
  alias Edge.{Api}

  def exchange_credentials_for_token(conn, %{ "email" => email, "password" => password }) do
    case Api.exchange_credentials_for_token(email, password) do
      {:ok, token} -> send(conn, 200, token)
      _ -> send(conn, 200, nil)
    end

  end

end
