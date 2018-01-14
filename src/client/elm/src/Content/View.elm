module Content.View exposing (view)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Route exposing (Route)
import Content.Types exposing (..)

view : Model -> Html Msg
view model =
    (div []
        [ text "You are viewing the Content page"
        ])
