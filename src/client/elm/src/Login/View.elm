module Login.View exposing (view)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Route exposing (Route)
import Login.Types exposing (..)


view : Model -> Html Msg
view model =
    (Html.form []
        [ div [ class "form-group" ]
            [ input [ type_ "email"
                    , class "form-control"
                    , id "email1"
                    , placeholder "Email"
                    , onInput UpdateEmail ] []
            ]
        , div [ class "form-group" ]
            [ input [ type_ "password"
                    , class "form-control"
                    , id "password1"
                    , placeholder "Password"
                    , onInput UpdatePassword ] []
            ]
        , div [ class "form-check" ] []
        , button [ class "btn"
                 , onSubmit Submit ] [ text "Submit" ]
        ])
