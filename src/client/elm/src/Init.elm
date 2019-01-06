module Init exposing (init)

import Browser.Navigation exposing (Key, pushUrl)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Ports exposing (createSubscriptions)
import RemoteData exposing (RemoteData)
import Route exposing (fromUrl, routeToString)
import Types as Types exposing (..)
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
                    , subscriptionStatus = NotConnected
                    , token = Nothing
                    }
              , homeModel = Nothing
              , contentModel =
                    { count = Nothing
                    }
              , loginModel =
                    { email = "demo@example.com"
                    , password = "foo"
                    , valid = True
                    , submitted = False
                    , request = RemoteData.NotAsked
                    }
              , frameModel =
                    { snackBarModel =
                        { showSnack = False
                        }
                    }
              , counterState = Nothing
              }
            , Cmd.batch
                [ pushUrl key (routeToString Route.Home)
                ]
            )
