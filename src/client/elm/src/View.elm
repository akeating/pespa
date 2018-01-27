module View exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Navigation exposing (Location)
import Route exposing (Route, fromLocation)
import Types exposing (..)
import Feature.Frame as Frame
import Feature.Home as Home
import Feature.Login as Login
import Feature.Content as Content


view : Model -> Html Msg
view model =
    let
        { context, homeModel, contentModel, loginModel, frameModel } = model
        maybeRoute = fromLocation context.location
    in
        case maybeRoute of
            Just Route.Login ->
                Frame.view frameModel (Login.view loginModel context)

            Just Route.Home ->
                Frame.view frameModel (Home.view homeModel context)

            Just Route.Content ->
                Frame.view frameModel (Content.view contentModel context)

            _ ->
                Frame.view frameModel (Home.view homeModel context)


viewLocation : Location -> Html Msg
viewLocation location =
    text (location.pathname ++ location.hash)
