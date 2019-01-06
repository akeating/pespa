port module Ports exposing (createSubscriptions, disconnectSocket, gotSubscriptionData, socketStatusClosed, socketStatusConnected, socketStatusReconnecting)

import Json.Decode exposing (..)
import Types exposing (Token)


port createSubscriptions : ( Token, String ) -> Cmd msg


port gotSubscriptionData : (Json.Decode.Value -> msg) -> Sub msg


port socketStatusConnected : (() -> msg) -> Sub msg


port socketStatusReconnecting : (() -> msg) -> Sub msg


port disconnectSocket : () -> Cmd msg


port socketStatusClosed : (() -> msg) -> Sub msg
