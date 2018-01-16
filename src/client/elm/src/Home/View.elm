module Home.View exposing (view)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Route exposing (Route)
import Common.Types exposing (Context)
import Home.Types exposing (..)


view : Model -> Context -> Html Msg
view model context =
    (div [ class "page home-page" ]
        [ div [ class "header" ]
            [ button [ class "btn btn-link" ] [ text "Login" ]]
        , div [ class "content" ]
            [ text "You are viewing the Home page" ]
        ])
