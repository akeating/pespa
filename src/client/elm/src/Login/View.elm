module Login.View exposing (view)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Json.Decode as Json exposing (Decoder)
import Route exposing (Route)
import Login.Types exposing (..)
import Common.Types


view : Model -> Html Msg
view model =
    (Html.form [ preventDefault ]
        [ div [ class "form-group" ]
            [ input [ type_ "email"
                    , class "form-control"
                    , id "email1"
                    , placeholder "Email"
                    , value model.email
                    , name "email"
                    , onInput UpdateEmail
                    ] []
            ]
        , div [ class "form-group" ]
            [ input [ type_ "password"
                    , class "form-control"
                    , id "password1"
                    , value model.password
                    , placeholder "Password"
                    , name "password"
                    , onInput UpdatePassword
                    ] []
            ]
        , div [ class "form-check" ] []
        , button [ class "btn"
                 , disabled (not model.valid)
                 , onClick Submit
                 ] [ text "Submit" ]
        ])


preventDefault : Attribute Msg
preventDefault =
    attribute "onsubmit" "event.preventDefault(); event.stopImmediatePropagation();"
