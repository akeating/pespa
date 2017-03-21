defmodule Edge.GuardianSerializer do
  @behaviour Guardian.Serializer

    alias Edge.Api

    def for_token(_user = %{id: id}), do: { :ok, "User:#{id}" }
    def for_token(_), do: { :error, "Unknown resource type" }

    def from_token("User:" <> id), do: { :ok, Api.findUser(id) }
    def from_token(_), do: { :error, "Unknown resource type" }
end
