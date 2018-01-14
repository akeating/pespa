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

contentWrapper : Model -> Html Msg -> Html Msg
contentWrapper model content =
    div [ class "content" ]
        [ content ]

footer : Model -> Html Msg
footer model =
    div [ class "footer" ]
        []
