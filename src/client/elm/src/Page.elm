module Page exposing (viewPage)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Navigation exposing (Location)
import Model exposing (Model)
import Messages exposing (..)
import Route exposing (Route)

type Page
    = Home


viewPage : Model -> Html Msg
viewPage model =
    withFrame
        (div []
            [ ul []
                [ li []
                    [ button [ onClick ( SetRoute Route.Login ) ] [ text "Login" ] ]
                , li []
                    [ button [ onClick ( SetRoute Route.Home ) ] [ text "Home" ] ]
                ]
            , ul [] (List.map viewLocation model.history)
            ])

-- INTERNAL


viewLocation : Location -> Html Msg
viewLocation location =
    li [] [ text (location.pathname ++ location.hash) ]


withFrame : (Html Msg) -> Html Msg
withFrame content =
    div [ class "wrapper" ]
        [ header
        , div [ class "content" ]
            [ content ]
        , footer
        ]

header : Html Msg
header =
    div [ class "header" ]
        []

footer : Html Msg
footer =
    div [ class "footer" ]
        []
