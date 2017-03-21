defmodule Edge.Web do
  @moduledoc """
  A module that keeps using definitions for controllers,
  views and so on.

  This can be used in your application as:

      use Edge.Web, :controller
      use Edge.Web, :view

  The definitions below will be executed for every view,
  controller, etc, so keep them short and clean, focused
  on imports, uses and aliases.

  Do NOT define functions inside the quoted expressions
  below.
  """

  def controller do
    quote do
      use Phoenix.Controller, namespace: Edge.Web
      import Plug.Conn
      import Edge.Web.Router.Helpers
      import Edge.Web.Gettext

      def not_found(conn, _params) do
        send_error(conn, 404, "Not found")
      end

      defp send_error(conn, status, message) do
        send(conn, status, message)
      end

      defp send(conn, status, message) do
        conn |> put_status(status) |> json(%{ error: message })
      end
    end
  end

  def view do
    quote do
      use Phoenix.View, root: "lib/edge/web/templates",
                        namespace: Edge.Web

      # Import convenience functions from controllers
      import Phoenix.Controller, only: [get_csrf_token: 0, get_flash: 2, view_module: 1]

      # Use all HTML functionality (forms, tags, etc)
      use Phoenix.HTML

      import Edge.Web.Router.Helpers
      import Edge.Web.ErrorHelpers
      import Edge.Web.Gettext
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
      import Edge.Web.Gettext
    end
  end

  @doc """
  When used, dispatch to the appropriate controller/view/etc.
  """
  defmacro __using__(which) when is_atom(which) do
    apply(__MODULE__, which, [])
  end
end
