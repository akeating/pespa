module Login.State exposing (..)

import Login.Types exposing (..)


init : ( Model, Cmd Msg )
init =
    ( initialState, Cmd.none )


initialState : Model
initialState =
    { email = ""
    , password = ""
    }


update : Msg -> Model -> Model
update msg model =
    case msg of
        UpdateEmail email ->
            { model | email = email }

        UpdatePassword password ->
            { model | password = password }

        Submit ->
            model
