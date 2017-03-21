defmodule Edge.User do
  use Ecto.Schema

  # import Ecto
  import Ecto.Changeset
  # import Ecto.Query

  schema "users" do
    field :name, :string
    field :email, :string
    field :password_hash, :string
    timestamps()
  end

  @required_fields ~w(name email password_hash)

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :email, :password_hash])
    |> validate_required(@required_fields)
    |> unique_constraint(:email)
  end
end
