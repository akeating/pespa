defmodule DomainWeb do
  @moduledoc """
  The entrypoint for defining your web interface, such
  as controllers, views, channels and so on.

  This can be used in your application as:

      use DomainWeb, :controller
      use DomainWeb, :view

  The definitions below will be executed for every view,
  controller, etc, so keep them short and clean, focused
  on imports, uses and aliases.

  Do NOT define functions inside the quoted expressions
  below. Instead, define any helper function in modules
  and import those modules here.
  """

  def controller do
    quote do
      use Phoenix.Controller, namespace: DomainWeb
      import Plug.Conn
      import DomainWeb.Gettext
      alias DomainWeb.Router.Helpers, as: Routes

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
      use Phoenix.View,
        root: "lib/domain_web/templates",
        namespace: DomainWeb

      # Import convenience functions from controllers
      import Phoenix.Controller, only: [get_flash: 1, get_flash: 2, view_module: 1]

      import DomainWeb.ErrorHelpers
      import DomainWeb.Gettext
      alias DomainWeb.Router.Helpers, as: Routes
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
      import DomainWeb.Gettext
    end
  end

  @doc """
  When used, dispatch to the appropriate controller/view/etc.
  """
  defmacro __using__(which) when is_atom(which) do
    apply(__MODULE__, which, [])
  end
end
