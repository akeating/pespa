module Init exposing (init, socketUrl)

import Browser.Navigation exposing (Key, pushUrl)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Route exposing (fromUrl, routeToString)
import Types exposing (..)
import Url exposing (Url)


init : () -> Url -> Key -> ( Model, Cmd msg )
init flags url key =
    let
        route =
            fromUrl url
    in
    case route of
        _ ->
            ( { context =
                    { key = key
                    , url = url
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
              , frameModel =
                    { snackBarModel =
                        { showSnack = False
                        }
                    }
              , counterState = Nothing
              }
            , Cmd.batch [ pushUrl key (routeToString Route.Home) ]
            )


socketUrl : String
socketUrl =
    "ws://localhost:3000/socket/websocket?vsn=2.0.0"
