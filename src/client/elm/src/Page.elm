module Page exposing (viewPage)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Navigation exposing (Location, newUrl)
import Model exposing (Model)
import Messages exposing (..)


type Page
    = Home


viewPage : Model -> Html Msg
viewPage model =
    withFrame
        (div []
            [ ul []
                [ li []
                    [ button [ onClick ( NewUrl "/login" ) ] [ text "Login" ] ]
                , li []
                    [ button [ onClick ( NewUrl "/home" ) ] [ text "Home" ] ]
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
