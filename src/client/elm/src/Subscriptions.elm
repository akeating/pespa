module Subscriptions exposing (subscriptions)

import Json.Decode exposing (Error, Value, decodeValue, field, string)
import Ports exposing (gotSubscriptionData, socketStatusConnected, socketStatusReconnecting)
import Result
import Types exposing (..)


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ gotSubscriptionData SubscriptionDataReceived
        , socketStatusConnected (NewSubscriptionStatus Connected)
        , socketStatusReconnecting (NewSubscriptionStatus Reconnecting)
        ]
