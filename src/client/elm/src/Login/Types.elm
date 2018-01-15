module Login.Types exposing (..)

import Http
import Common.Types exposing (User, Email, Password)


type alias Model =
    { email : Email
    , password : Password
    , valid : Bool
    , submitted : Bool
    }


type Msg
    = Submit
    | UpdateEmail Email
    | UpdatePassword Password
    | AuthenticateComplete (Result Http.Error User)
