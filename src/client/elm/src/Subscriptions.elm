module Subscriptions exposing (subscriptions)

import Json.Decode exposing (Error, Value, decodeValue, field, string)
import Ports exposing (gotSubscriptionData, socketStatusConnected, socketStatusReconnecting)
import Result
import Types exposing (..)



-- subscriptions : Model -> Sub Msg
-- subscriptions model =
--     handleAuthenticate handleAuthenticateReceived
-- handleAuthenticateReceived : Value -> Msg
-- handleAuthenticateReceived modelJson =
--     case decodeModel modelJson of
--         Ok email ->
--             AuthenticateComplete (Ok (User email))
--         Err errorMessage ->
--             let
--                 _ =
--                     Debug.log "Error in handleAuthenticate:" errorMessage
--             in
--             NoOp
-- decodeModel : Value -> Result Error String
-- decodeModel modelJson =
--     decodeValue (field "email" string) modelJson


subscriptions : Model -> Sub Msg
subscriptions model =
    -- Graphql.Subscription.listen GraphqlSubscriptionMsg model.graphqlSubscriptionModel
    Sub.batch
        [ gotSubscriptionData SubscriptionDataReceived
        , socketStatusConnected (NewSubscriptionStatus Connected)
        , socketStatusReconnecting (NewSubscriptionStatus Reconnecting)
        ]
