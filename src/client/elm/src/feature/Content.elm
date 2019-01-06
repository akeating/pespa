module Feature.Content exposing (update, view)

import Common.Api as Api exposing (unpackSubscriptionData)
import Common.View exposing (getPageHeader)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Route exposing (Route)
import Types exposing (..)


update : Msg -> ContentModel -> Context -> ( ContentModel, Cmd Msg )
update msg contentModel context =
    case Api.unpackSubscriptionData msg of
        Just counterState ->
            ( { contentModel | count = Just counterState.count }
            , Cmd.none
            )

        _ ->
            ( contentModel, Cmd.none )


view : ContentModel -> Context -> Html Msg
view contentModel context =
    div [ class "content-page" ]
        [ getPageHeader context
        , viewPageBody contentModel context
        ]


viewPageBody : ContentModel -> Context -> Html Msg
viewPageBody contentModel context =
    let
        countString =
            case contentModel.count of
                Just value ->
                    String.fromInt value

                _ ->
                    ""
    in
    div [ class "page-body" ]
        [ span []
            [ text "You are viewing the Content page" ]
        , span []
            [ text countString ]
        ]
