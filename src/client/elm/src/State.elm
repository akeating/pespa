module State exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Navigation exposing (Location, newUrl)
import Route exposing (modifyUrl, fromLocation)
import Types exposing (..)
import Home.State
import Login.State
import Content.State

init : Location -> ( Model, Cmd Msg )
init location =
    let
        route = fromLocation location
    in
        case route of
            Nothing ->
                ( initialState location
                , modifyUrl Route.Home
                )

            _ ->
                ( initialState location
                , Cmd.none
                )

initialState : Location -> Model
initialState location =
    { location = location
    , home = Home.State.initialState
    , login = Login.State.initialState
    , content = Content.State.initialState
    }


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        UrlChange location ->
            ( { model | location = location }
            , Cmd.none
            )

        SetRoute route ->
            ( model, modifyUrl route )

        LoginMsg subMsg ->
            ( model, Cmd.none )

        HomeMsg subMsg ->
            ( model, Cmd.none )

        ContentMsg subMsg ->
            ( model, Cmd.none )
