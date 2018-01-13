module App exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Navigation exposing (Location, newUrl)
import Model exposing (Model)
import Messages exposing (..)
import Route exposing (modifyUrl, fromLocation)
import Pages.Home
import Pages.Login

init : Location -> ( Model, Cmd Msg )
init location =
    let
        route = fromLocation location
    in
        case route of
            Nothing ->
                ( Model location
                , modifyUrl Route.Home
                )

            _ ->
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
    let
        maybeRoute = fromLocation model.location
    in
    case maybeRoute of
        Just Route.Login ->
            Pages.Login.view model

        Just Route.Home ->
            Pages.Home.view model

        _ ->
            Pages.Home.view model
