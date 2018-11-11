module Subscriptions exposing (subscriptions)

import Types exposing (..)
import Ports exposing (handleAuthenticate)
import Json.Decode exposing(field, string, Value, decodeValue, Error)
import Result


subscriptions : Model -> Sub Msg
subscriptions model =
    handleAuthenticate handleAuthenticateReceived

handleAuthenticateReceived : Value -> Msg
handleAuthenticateReceived modelJson =
    case (decodeModel modelJson) of
        Ok email ->
            AuthenticateComplete (Ok (User email))

        Err errorMessage ->
            let
                _ =
                    Debug.log "Error in handleAuthenticate:" errorMessage
            in
                NoOp

decodeModel : Value -> Result Error String
decodeModel modelJson =
    decodeValue (field "email" string) modelJson
