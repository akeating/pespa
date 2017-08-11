defmodule Edge.Graphql.Schema do
  use Absinthe.Schema

  alias Edge.Graphql.Resolvers

  query do

    @desc "Who am I?"
    field :whoami, :user do
      resolve &Resolvers.whoami/2
    end

  end

  @desc "a User"
  object :user do
    field :id, :integer
    field :name, :string
    field :email, :string
  end

end
