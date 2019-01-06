module Common.View exposing (getLogo, getPageHeader, getUserRef)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Route exposing (Route, fromUrl)
import Types exposing (..)


getPageHeader : Context -> Html Msg
getPageHeader context =
    let
        route =
            fromUrl context.url
    in
    div [ class "page-header" ]
        [ getLogo route
        , getContentLink route context
        , div [ class "filler" ] []
        , span [ class "user-ref" ]
            [ getUserRef route context.user ]
        ]


getLogo : Maybe Route -> Html Msg
getLogo route =
    case route of
        Just Route.Home ->
            span []
                [ text "Logo" ]

        _ ->
            button
                [ class "btn btn-link logo-btn"
                , tabindex -1
                , onClick LogoClick
                ]
                [ text "Logo" ]


getContentLink : Maybe Route -> Context -> Html Msg
getContentLink route context =
    case route of
        Just Route.Content ->
            text ""

        _ ->
            case context.user of
                Just user ->
                    button
                        [ class "btn btn-link content-btn"
                        , tabindex -1
                        , onClick ContentClick
                        ]
                        [ text "Content" ]

                _ ->
                    text ""


getUserRef : Maybe Route -> Maybe User -> Html Msg
getUserRef route maybeUser =
    case route of
        Just Route.Login ->
            text ""

        _ ->
            case maybeUser of
                Just user ->
                    div [ class "logged-in" ]
                        [ span []
                            [ text ("Logged in as: " ++ user.email) ]
                        , button [ class "btn btn-link user-ref-btn", onClick Logout ]
                            [ text "Logout" ]
                        ]

                _ ->
                    button [ class "btn btn-link user-ref-btn", onClick (SetRoute Route.Login) ]
                        [ text "Login" ]
