defmodule Edge.Graphql.Schema do
  use Absinthe.Schema

  alias Edge.Graphql.Resolvers

  query do

    field :exchange_credentials_for_token, :string do
      arg :email, :string
      arg :password, :string
      resolve &Resolvers.exchange_credentials_for_token/2
    end

    @desc "Who am I?"
    field :whoami, :user do
      resolve &Resolvers.whoami/2
    end

  end

  mutation do
    field :increment_count_by, :counter_state do
      arg :by, :integer
      resolve &Resolvers.increment_count_by/2
    end
  end

  object :counter_state do
    field :version, :integer
    field :count, :integer
  end

  @desc "a User"
  object :user do
    field :id, :integer
    field :name, :string
    field :email, :string
  end

  subscription do

    field :count_changed, :counter_state do
      config fn _args, _info ->
        {:ok, topic: ""}
      end
      trigger :increment_count_by, topic: fn _ ->
        ""
      end
    end

  end

end
