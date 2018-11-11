module Feature.Content exposing (update, view)

import Common.View exposing (getPageHeader)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Route exposing (Route)
import Types exposing (..)


update : Msg -> ContentModel -> Context -> ( ContentModel, Cmd Msg )
update msg contentModel context =
    ( contentModel, Cmd.none )


view : ContentModel -> Context -> Html Msg
view contentModel context =
    div [ class "content-page" ]
        [ getPageHeader context
        , viewPageBody contentModel context
        ]


viewPageBody : ContentModel -> Context -> Html Msg
viewPageBody contentModel context =
    div [ class "page-body" ]
        [ span []
            [ text "You are viewing the Content page" ]
        ]
