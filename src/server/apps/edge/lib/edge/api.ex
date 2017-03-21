defmodule Edge.Api do

  import Ecto.Query
  alias Edge.User
  alias Edge.Repo
  alias Comeonin.Bcrypt

  def exchange_credentials_for_token(email, password) do
    select = from u in User, where: u.email == ^email
    user = Repo.one(select)
    if user == nil do
      {:error, :not_found}
    else
      hash = user.password_hash
      if Bcrypt.checkpw(password, hash) do
        case Guardian.encode_and_sign(user, :token) do
          {:ok, token, _full_claims } -> {:ok, token}
          _ -> {:error, :encode_and_sign}
        end
      else
        {:error, :invalid_password}
      end
    end
  end

  def findUser(id) do
    Repo.get(User, id)
  end

end
