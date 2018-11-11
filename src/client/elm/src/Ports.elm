port module Ports exposing (authenticate, handleAuthenticate)

import Json.Decode exposing (..)


port authenticate : String -> Cmd msg


port handleAuthenticate : (Value -> msg) -> Sub msg
