module Home.View exposing (view)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Route exposing (Route)
import Home.Types exposing (..)


view : Model -> Html Msg
view model =
    (div []
        [ text "You are viewing the Home page"
        ])
