module Login.State exposing (..)

import Task exposing (Task)
import Login.Types exposing (..)
import Login.Tasks exposing (authenticate)
import Common.Types exposing (Email, Password, Context)


init : ( Model, Cmd Msg )
init =
    ( initialState, Cmd.none )


initialState : Model
initialState =
    { email = ""
    , password = ""
    , valid = False
    , submitted = False
    }


update : Msg -> Model -> Context -> (Model, Cmd Msg)
update msg model context =
    case msg of
        UpdateEmail email ->
            let
                newModel = { model | email = email }
                valid = validate newModel
            in
                ({ newModel | valid = valid }
                , Cmd.none)

        UpdatePassword password ->
            let
                newModel = { model | password = password }
                valid = validate newModel
            in
                ({ newModel | valid = valid }
                , Cmd.none)

        Submit ->
            ( { model | submitted = True }
            , authenticate model.email model.password AuthenticateComplete )

        AuthenticateComplete (Ok user) ->
            ( { model | submitted = False, email = "", password = "", valid = False }
            , Cmd.none )

        AuthenticateComplete (Err err) ->
            ( { model | submitted = False }
            , Cmd.none )


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
