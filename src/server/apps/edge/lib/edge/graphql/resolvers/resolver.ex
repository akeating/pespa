defmodule Edge.Graphql.Resolvers do

  def whoami _args, info do
    %{context: %{current_user: user}} = info
    {:ok, user}
  end

end
