defmodule Edge.Graphql.Resolvers do

  def whoami _args, info do
    %{context: %{current_user: user}} = info
    {:ok, user}
  end

  def increment_count_by %{by: by}, _info do
    {:ok, Domain.Accounts.increment_count_by by}
  end

end
