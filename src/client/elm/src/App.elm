module App exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Navigation exposing (Location, newUrl)
import Page exposing (viewPage)
import Model exposing (Model)
import Messages exposing (..)
import Route exposing (..)

init : Location -> ( Model, Cmd Msg )
init location =
    ( Model location
    , Cmd.none
    )


-- UPDATE


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        UrlChange location ->
            ( { model | location = location }
            , Cmd.none
            )

        SetRoute route ->
            ( model, modifyUrl route )


-- VIEW


view : Model -> Html Msg
view model =
    viewPage model
