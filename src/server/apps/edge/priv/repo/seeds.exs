alias Edge.{Repo, User}
#import Ecto.Changeset

Repo.transaction(fn ->

  # password is "foo"
  _user = Repo.insert!(%User{
    name: "Demo Example",
    email: "demo@example.com",
    password_hash: "$2b$12$hnuEjNt8FpFOK92oBlOwJ.gzG2JxaXX3Ae.MZeCj6GDpURmoFbmf6"
  })

end)
