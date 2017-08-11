defmodule Edge do
  @moduledoc """
  The entrypoint for defining your web interface, such
  as controllers, views, channels and so on.

  This can be used in your application as:

      use Edge, :controller
      use Edge, :view

  The definitions below will be executed for every view,
  controller, etc, so keep them short and clean, focused
  on imports, uses and aliases.

  Do NOT define functions inside the quoted expressions
  below. Instead, define any helper function in modules
  and import those modules here.
  """

  def controller do
    quote do
      use Phoenix.Controller, namespace: Edge
      import Plug.Conn
      import Edge.Router.Helpers
      import Edge.Gettext

      def not_found(conn, _params) do
        send_error(conn, 404, "Not found")
      end

      defp send_data(conn, status, data) do
        send(conn, status, %{ data: data })
      end

      defp send_error(conn, status, message) do
        send(conn, status, %{ error: message })
      end

      defp send(conn, status, body) do
        conn |> put_status(status) |> json(body)
      end
    end
  end

  def view do
    quote do
      use Phoenix.View, root: "lib/edge/templates",
                        namespace: Edge

      # Import convenience functions from controllers
      import Phoenix.Controller, only: [get_flash: 2, view_module: 1]

      import Edge.Router.Helpers
      import Edge.ErrorHelpers
      import Edge.Gettext
    end
  end

  def router do
    quote do
      use Phoenix.Router
      import Plug.Conn
      import Phoenix.Controller
    end
  end

  def channel do
    quote do
      use Phoenix.Channel
      import Edge.Gettext
    end
  end

  @doc """
  When used, dispatch to the appropriate controller/view/etc.
  """
  defmacro __using__(which) when is_atom(which) do
    apply(__MODULE__, which, [])
  end
end
