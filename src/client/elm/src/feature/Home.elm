module Feature.Home exposing (update, view)

import Common.View exposing (getPageHeader)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Route exposing (Route)
import Types exposing (..)


update : Msg -> HomeModel -> Context -> ( HomeModel, Cmd Msg )
update msg homeModel context =
    ( homeModel, Cmd.none )


view : HomeModel -> Context -> Html Msg
view homeModel context =
    div [ class "home-page" ]
        [ getPageHeader context
        , viewPageBody homeModel context
        ]


viewPageBody : HomeModel -> Context -> Html Msg
viewPageBody homeModel context =
    div [ class "page-body" ]
        [ span []
            [ text "You are viewing the Home page" ]
        ]
