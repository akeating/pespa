module Content.State exposing (..)

import Content.Types exposing (..)


init : ( Model, Cmd Msg )
init =
    ( initialState, Cmd.none )


initialState : Model
initialState =
    Nothing


update : Msg -> Model -> ( Model, Cmd Msg )
update action model =
    case action of
        _ ->
            (model, Cmd.none)
