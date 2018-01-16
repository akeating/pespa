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
        maybeRoute = fromLocation model.context.location
    in
    case maybeRoute of
        Just Route.Login ->
            LoginView.view model.login model.context |> Html.map LoginMsg

        Just Route.Home ->
            HomeView.view model.home model.context |> Html.map HomeMsg

        Just Route.Content ->
            ContentView.view model.content model.context |> Html.map ContentMsg

        _ ->
            HomeView.view model.home model.context |> Html.map HomeMsg


viewLocation : Location -> Html Msg
viewLocation location =
    text (location.pathname ++ location.hash)
