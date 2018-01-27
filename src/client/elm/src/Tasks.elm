module Tasks exposing (..)

import Task exposing (Task)
import Types exposing (User, Email, Password)


authenticate : Email -> Password -> (Result err User -> msg) -> Cmd msg
authenticate email password msg =
    Task.attempt msg (Task.succeed (User email))
