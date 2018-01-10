module App exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Navigation exposing (Location, newUrl)
import Page exposing (viewPage)
import Model exposing (Model)
import Messages exposing (..)


init : Location -> ( Model, Cmd Msg )
init location =
    ( Model [ location ]
    , Cmd.none
    )


-- UPDATE


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        UrlChange location ->
            ( { model | history = location :: model.history }
            , Cmd.none
            )

        NewUrl url ->
            ( model, newUrl url )


-- VIEW


view : Model -> Html Msg
view model =
    viewPage model
