defmodule Domain.Accounts do

  import Ecto.Query
  alias Domain.Accounts.{User,Counter}
  alias Domain.Repo

  def exchange_credentials_for_token(email, password) do
    select = from u in User, where: u.email == ^email
    user = Repo.one(select)
    if user == nil do
      {:error, :not_found}
    else
      hash = user.password_hash
      if Bcrypt.verify_pass(password, hash) do
        {:ok, user}
      else
        {:error, :invalid_password}
      end
    end
  end

  def increment_count_by(by) do
    {:ok, Counter.increment_by by}
  end

  def find_user(id) do
    Repo.get(User, id)
  end

end
