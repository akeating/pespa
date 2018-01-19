module Feature.Content exposing (update, view)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Types exposing (..)
import Route exposing (Route)


update : Msg -> ContentModel -> Context -> (ContentModel, Cmd Msg)
update msg contentModel context =
    ( contentModel, Cmd.none )


view : ContentModel -> Context -> Html Msg
view contentModel context =
    (div [ class "content-page" ]
        [ text "You are viewing the Content page"
        ])
