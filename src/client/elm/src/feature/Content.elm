module Feature.Content exposing (update, view)

import Browser.Navigation exposing (pushUrl)
import Common.Api as Api exposing (unpackSubscriptionData)
import Common.View exposing (getPageHeader)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import RemoteData exposing (RemoteData)
import Route exposing (Route, routeToString)
import Types exposing (..)


update : Msg -> ContentModel -> Context -> ( ContentModel, Cmd Msg )
update msg contentModel context =
    case msg of
        SubscriptionDataReceived newData ->
            case Api.unpackSubscriptionData newData of
                Just counterState ->
                    ( { contentModel | count = Just counterState.count }
                    , Cmd.none
                    )

                _ ->
                    ( contentModel, Cmd.none )

        GotIncrementResponse (RemoteData.Success (Just counterState)) ->
            ( { contentModel | count = Just counterState.count }
            , Cmd.none
            )

        LogoClick ->
            ( contentModel, pushUrl context.key (routeToString Route.Home) )

        ContentClick ->
            ( contentModel, pushUrl context.key (routeToString Route.Content) )

        Decrement ->
            case context.token of
                Just value ->
                    ( contentModel, Api.incrementCountBy value -1 )

                _ ->
                    ( contentModel, Cmd.none )

        Increment ->
            case context.token of
                Just value ->
                    ( contentModel, Api.incrementCountBy value 1 )

                _ ->
                    ( contentModel, Cmd.none )

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
            [ button [ onClick Decrement ] [ text "-" ]
            , text (" " ++ countString ++ " ")
            , button [ onClick Increment ] [ text "+" ]
            ]
        ]
