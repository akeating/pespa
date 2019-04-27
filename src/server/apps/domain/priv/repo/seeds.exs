alias Domain.{Repo, Accounts}

Repo.transaction(fn ->

  # password is "foo"
  _user = Repo.insert!(%Accounts.User{
    name: "Demo Example",
    email: "demo@example.com",
    password_hash: "$2b$12$hnuEjNt8FpFOK92oBlOwJ.gzG2JxaXX3Ae.MZeCj6GDpURmoFbmf6"
  })

end)
