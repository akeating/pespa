defmodule Edge.UserSocket do
  use Phoenix.Socket
  use Absinthe.Phoenix.Socket,
    schema: Edge.Graphql.Schema
    
  alias Edge.Guardian

  # channel "__absinthe__:*", Absinthe.Phoenix.Channel

  def connect(%{"token" => token}, socket) do
    IO.inspect token
    case Guardian.decode_and_verify(token) do
      { :ok, claims } ->
        case Guardian.resource_from_claims(claims) do
          { :ok, user } ->
            socket = socket
            |> assign(:user_id, user.id)
            {:ok, socket}
          { :error, _reason } -> :error
        end
      { :error, _reason } -> :error
    end
  end

  def connect(_, _socket), do: :error

  def id(socket), do: "users_socket:#{socket.assigns.user_id}"
end
