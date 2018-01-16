module Home.View exposing (view)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Types exposing (..)
import Route exposing (Route)


view : HomeModel -> Context -> Html Msg
view homeModel context =
    (div [ class "page home-page" ]
        [ div [ class "header" ]
            [ button [ class "btn btn-link", onClick (SetRoute Route.Login) ]
                [ text "Login" ]]
        , div [ class "content" ]
            [ text "You are viewing the Home page" ]
        ])
