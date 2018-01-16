module Common.Types exposing (..)

import Navigation exposing (Location)

type alias Email = String

type alias Password = String

type alias User =
    { email : Email
    }

type alias Context =
    { location : Location
    , user : Maybe User
    }
