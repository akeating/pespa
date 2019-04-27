defmodule DomainWeb.Graphql.Resolvers do
  
  alias Domain.Accounts
  alias DomainWeb.Guardian

  def exchange_credentials_for_token %{ email: email, password: password }, _info do
    case Accounts.exchange_credentials_for_token(email, password) do
      {:ok, user} ->
        encode_and_sign(user)
      {:error, reason} ->
        {:error, reason}
    end
  end

  def whoami _args, info do
    %{context: %{current_user: user}} = info
    {:ok, user}
  end

  def increment_count_by %{by: by}, info do
    %{context: %{current_user: user}} = info
    if user == nil do
      {:error, :not_authorized }
    else
      Accounts.increment_count_by by
    end
  end

  defp encode_and_sign(user) do
    case Guardian.encode_and_sign(user) do
      {:ok, token, _full_claims } -> {:ok, token}
      _ -> {:error, :encode_and_sign}
    end
  end

end
