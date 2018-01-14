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
        maybeRoute = fromLocation model.location
    in
    case maybeRoute of
        Just Route.Login ->
            withFrame model "login-page" (LoginView.view model.login |> Html.map LoginMsg)

        Just Route.Home ->
            withFrame model "home-page" (HomeView.view model.home |> Html.map HomeMsg)

        Just Route.Content ->
            withFrame model "content-page" (ContentView.view model.content |> Html.map ContentMsg)

        _ ->
            withFrame model "home-page" (HomeView.view model.home |> Html.map HomeMsg)



viewLocation : Location -> Html Msg
viewLocation location =
    text (location.pathname ++ location.hash)


withFrame : Model -> String -> Html Msg -> Html Msg
withFrame model contentClass content =
    div [ class "wrapper" ]
        [ header model
        , contentWrapper model contentClass content
        , footer model
        ]

header : Model -> Html Msg
header model =
    div [ class "header" ]
        [ button [ class "btn"
                 , onClick ( SetRoute Route.Home )
                 ] [ text "Home" ]
        , button [ class "btn"
                 , onClick ( SetRoute Route.Login )
                 ] [ text "Login" ]
        , button [ class "btn"
                 , onClick ( SetRoute Route.Content )
                 ] [ text "Content" ]
        ]

contentWrapper : Model -> String -> Html Msg -> Html Msg
contentWrapper model contentClass content =
    div [ classList
            [ ( "content", True )
            , ( contentClass, True )
            ]
        ]
        [ content ]

footer : Model -> Html Msg
footer model =
    div [ class "footer" ]
        []
