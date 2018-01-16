module Login.View exposing (view)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Types exposing (..)
import Route exposing (Route)


view : LoginModel -> Context -> Html Msg
view loginModel context =
    (div [ class "page login-page" ]
        [ Html.form [ preventDefault "onsubmit" ]
            [ div [ class "form-group" ]
                [ input [ type_ "email"
                        , class "form-control"
                        , id "email1"
                        , placeholder "Email"
                        , value loginModel.email
                        , name "email"
                        , onInput LoginUpdateEmail
                        ] []
                ]
            , div [ class "form-group" ]
                [ input [ type_ "password"
                        , class "form-control"
                        , id "password1"
                        , value loginModel.password
                        , placeholder "Password"
                        , name "password"
                        , onInput LoginUpdatePassword
                        ] []
                ]
            , div [ class "form-check" ] []
            , button [ class "btn"
                     , disabled (not loginModel.valid)
                     , onClick LoginSubmit
                     ] [ text "Submit" ]
            ]
        ])


preventDefault : String -> Attribute Msg
preventDefault event =
    attribute event "event.preventDefault(); event.stopImmediatePropagation();"
