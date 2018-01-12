module Pages.Login exposing (view)

import Model exposing (Model)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Messages exposing (..)
import Route exposing (Route)
import Views.Page exposing (withFrame, viewLocation)

view : Model -> Html Msg
view model =
    withFrame model
        (div []
            [ text "You are viewing the Login page"
            ])
