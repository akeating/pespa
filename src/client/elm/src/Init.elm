module Init exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Navigation exposing (Location, newUrl)
import Route exposing (modifyUrl, fromLocation)
import Types exposing (..)


init : Location -> ( Model, Cmd Msg )
init location =
    let
        route = fromLocation location
    in
        case route of
            _ ->
                ( initialState location
                , modifyUrl Route.Home
                )


initialState : Location -> Model
initialState location =
    { context =
        { location = location
        , user = Nothing
        }
    , homeModel = Nothing
    , contentModel = Nothing
    , loginModel =
        { email = ""
        , password = ""
        , valid = False
        , submitted = False
        }
    }
