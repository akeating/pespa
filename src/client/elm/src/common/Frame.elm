module Common.Frame exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Types exposing (..)


view : Model -> Html Msg -> Html Msg
view model page =
    (div [ class "frame" ]
        [ div [ class "header" ]
            [ button [ class "btn"
                     , onClick ApiNetworkError
                     ] [ text "Simulate ApiNetworkError" ]
            ]
        , div [ class "page" ]
            [ page ]
        ])
