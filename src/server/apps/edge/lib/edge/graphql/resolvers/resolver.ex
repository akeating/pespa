defmodule Edge.Graphql.Resolvers do
  # alias Edge.Api
  # alias Edge.{User, Repo}

  def whoami _args, info do
    %{context: %{current_user: user}} = info
    {:ok, user}
  end

end
