module Common.View exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Types exposing (..)
import Route exposing (Route, fromLocation)


preventDefault : String -> Attribute Msg
preventDefault event =
    attribute event "event.preventDefault(); event.stopImmediatePropagation();"


getPageHeader : Context -> Html Msg
getPageHeader context =
    let
        route = fromLocation context.location
    in
    div [ class "page-header" ]
        [ getLogo route
        , div [ class "filler" ] []
        , span [ class "user-ref" ]
            [getUserRef route context.user]
        ]


getLogo : Maybe Route -> Html Msg
getLogo route =
    case route of
        Just Route.Home ->
            span []
                [ text "Logo" ]

        _ ->
            button [ class "btn btn-link logo-btn"
                , tabindex -1
                , onClick LogoClick
                ] [ text "Logo" ]


getUserRef : Maybe Route -> Maybe User -> Html Msg
getUserRef route user =
    case route of
        Just Route.Login ->
            text ""

        _ ->
            case user of
                Just user ->
                    div [ class "logged-in" ]
                        [ span []
                            [ text ("Logged in as: " ++ user.email) ]
                        , button [ class "btn btn-link user-ref-btn", onClick (Logout) ]
                            [ text "Logout" ]]

                _ ->
                    button [ class "btn btn-link user-ref-btn", onClick (SetRoute Route.Login) ]
                        [ text "Login" ]
