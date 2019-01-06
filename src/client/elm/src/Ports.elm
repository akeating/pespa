port module Ports exposing (createSubscriptions, gotSubscriptionData, socketStatusConnected, socketStatusReconnecting)

import Json.Decode exposing (..)
import Types exposing (Token)


port createSubscriptions : ( Token, String ) -> Cmd msg


port gotSubscriptionData : (Json.Decode.Value -> msg) -> Sub msg


port socketStatusConnected : (() -> msg) -> Sub msg


port socketStatusReconnecting : (() -> msg) -> Sub msg
