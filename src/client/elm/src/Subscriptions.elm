module Subscriptions exposing (subscriptions)

import Graphqelm.Subscription exposing (listen)
import Types exposing (..)


subscriptions : Model -> Sub Msg
subscriptions model =
    listen GraphqlSubscriptionMsg model
