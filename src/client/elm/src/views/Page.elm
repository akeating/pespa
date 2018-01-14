module Views.Page exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Navigation exposing (Location)
import Model exposing (Model)
import Messages exposing (..)
import Route exposing (Route)


viewLocation : Location -> Html Msg
viewLocation location =
    text (location.pathname ++ location.hash)


withFrame : Model -> Html Msg -> Html Msg
withFrame model content =
    div [ class "wrapper" ]
        [ header model
        , contentWrapper model content
        , footer model
        ]

header : Model -> Html Msg
header =
    div [ class "header" ]
        [ button [ onClick ( SetRoute Route.Home ) ] [ text "Home" ]
        , button [ onClick ( SetRoute Route.Login ) ] [ text "Login" ]
        , button [ onClick ( SetRoute Route.Content ) ] [ text "Content" ]
        ]

contentWrapper : Model -> Html Msg -> Html Msg
contentWrapper content =
    div [ class "content" ]
        [ content ]

footer : Model -> Html Msg
footer =
    div [ class "footer" ]
        []
