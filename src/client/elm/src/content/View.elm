module Content.View exposing (view)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Types exposing (..)
import Route exposing (Route)


view : ContentModel -> Context -> Html Msg
view contentModel context =
    (div [ class "page content-page" ]
        [ text "You are viewing the Content page"
        ])
