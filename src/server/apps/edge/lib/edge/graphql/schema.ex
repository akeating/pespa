defmodule Edge.Graphql.Schema do
  use Absinthe.Schema

  alias Edge.Graphql.Resolvers

  query do

    @desc "Who am I?"
    field :whoami, :user do
      resolve &Resolvers.whoami/2
    end

  end

  mutation do
    field :increment_count_by, :integer do
      arg :by, :integer
      resolve &Resolvers.increment_count_by/2
    end
  end

  @desc "a User"
  object :user do
    field :id, :integer
    field :name, :string
    field :email, :string
  end

  subscription do

    field :count_changed, :integer do
      trigger :increment_count_by
    end

  end

end
