module View exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Navigation exposing (Location)
import Route exposing (Route, fromLocation)
import Types exposing (..)
import Home.View as HomeView
import Login.View as LoginView
import Content.View as ContentView


view : Model -> Html Msg
view model =
    let
        { context, homeModel, contentModel, loginModel } = model
        maybeRoute = fromLocation context.location
    in
        case maybeRoute of
            Just Route.Login ->
                LoginView.view loginModel context

            Just Route.Home ->
                HomeView.view homeModel context

            Just Route.Content ->
                ContentView.view contentModel context

            _ ->
                HomeView.view homeModel context


viewLocation : Location -> Html Msg
viewLocation location =
    text (location.pathname ++ location.hash)
