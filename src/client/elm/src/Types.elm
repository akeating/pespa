module Types exposing (..)

import Route exposing (Route)
import Navigation exposing (Location)
import Common.Types
import Home.Types
import Login.Types
import Content.Types

type alias Model =
    { location : Location
    , user : Maybe User
    , home : Home.Types.Model
    , login : Login.Types.Model
    , content : Content.Types.Model
    }


type Msg
    = UrlChange Location
    | SetRoute Route
    | LoginMsg Login.Types.Msg
    | HomeMsg Home.Types.Msg
    | ContentMsg Content.Types.Msg


type alias User =
    { email : Common.Types.Email
    }
