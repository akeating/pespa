defmodule Edge2.GuardianSerializer do
  @behaviour Guardian.Serializer

    alias Domain.Accounts

    def for_token(_user = %{id: id}), do: { :ok, "User:#{id}" }
    def for_token(_), do: { :error, "Unknown resource type" }

    def from_token("User:" <> id), do: { :ok, Accounts.find_user(id) }
    def from_token(_), do: { :error, "Unknown resource type" }
end
