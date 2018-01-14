module Login.State exposing (..)

import Login.Types exposing (..)
import Common.Types exposing (Email, Password)

init : ( Model, Cmd Msg )
init =
    ( initialState, Cmd.none )


initialState : Model
initialState =
    { email = ""
    , password = ""
    , valid = False
    }


update : Msg -> Model -> Model
update msg model =
    case msg of
        UpdateEmail email ->
            let
                newModel = { model | email = email }
                valid = validate newModel
            in
                { newModel | valid = valid }

        UpdatePassword password ->
            let
                newModel = { model | password = password }
                valid = validate newModel
            in
                { newModel | valid = valid }

        Submit ->
            model

validate : Model -> Bool
validate model =
    validateEmail model.email &&
    validatePassword model.password

validateEmail: Email -> Bool
validateEmail email =
    String.contains "@" email &&
    String.contains "." email

validatePassword: Password -> Bool
validatePassword password =
    String.length password >= 8
