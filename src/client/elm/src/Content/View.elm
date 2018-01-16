module Content.View exposing (view)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Route exposing (Route)
import Common.Types exposing (Context)
import Content.Types exposing (..)

view : Model -> Context -> Html Msg
view model context =
    (div [ class "content-page" ]
        [ text "You are viewing the Content page"
        ])
