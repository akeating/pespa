module Login.Types exposing (..)

import Common.Types

type alias Model =
    { email : Common.Types.Email
    , password : Common.Types.Password
    , valid : Bool
    }


type Msg
    = Submit
    | UpdateEmail Common.Types.Email
    | UpdatePassword Common.Types.Password
