module Common.View exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Types exposing (..)
import Route exposing (Route)


preventDefault : String -> Attribute Msg
preventDefault event =
    attribute event "event.preventDefault(); event.stopImmediatePropagation();"


getPageHeader : Bool -> Context -> Html Msg
getPageHeader showLogo context =
    div [ class "page-header" ]
        [ button [ class "btn btn-link"
            , tabindex -1
            , onClick LogoClick
            ] [ text "Logo" ]
        , div [ class "filler" ] []
        , span [ class "user-ref" ]
            [getUserRef context]
        ]


getUserRef : Context -> Html Msg
getUserRef context =
    case context.user of
        Just user ->
            text ("Logged in as: " ++ user.email)
        _ ->
            button [ class "btn btn-link", onClick (SetRoute Route.Login) ]
                [ text "Login" ]
