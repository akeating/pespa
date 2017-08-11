defmodule Edge2.ApiController do
  use Edge2, :controller
  alias Domain.Accounts

  def exchange_credentials_for_token(conn, %{ "email" => email, "password" => password }) do
    case Accounts.exchange_credentials_for_token(email, password) do
      {:ok, user} ->
        encoded = encode_and_sign(user)
        respond(conn, encoded)
      result ->
        IO.inspect result
        respond(conn)
    end
  end

  defp respond(conn, {:ok, token}), do: send_data(conn, 200, token)
  defp respond(conn, _), do: respond(conn)
  defp respond(conn), do: send_data(conn, 401, nil)

  defp encode_and_sign(user) do
    case Guardian.encode_and_sign(user, :token) do
      {:ok, token, _full_claims } -> {:ok, token}
      _ -> {:error, :encode_and_sign}
    end
  end
end
