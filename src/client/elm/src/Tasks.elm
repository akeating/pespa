module Tasks exposing (authenticate)

import Task exposing (Task)
import Types exposing (Email, Password, User)


authenticate : Email -> Password -> (Result err User -> msg) -> Cmd msg
authenticate email password msg =
    Task.attempt msg (Task.succeed (User email))
