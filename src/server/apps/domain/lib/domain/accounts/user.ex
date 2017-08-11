defmodule Domain.Accounts.User do
  use Ecto.Schema

  import Ecto.Changeset
  alias Domain.Accounts.User

  schema "users" do
    field :name, :string
    field :email, :string
    field :password_hash, :string
    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:name, :email, :password_hash])
    |> validate_required([:name, :email, :password_hash])
    |> unique_constraint(:email)
  end
end
