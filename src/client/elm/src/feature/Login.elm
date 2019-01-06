module Feature.Login exposing (update, view)

import Browser.Navigation exposing (pushUrl)
import Common.Api as Api exposing (exchangeCredentialsForToken)
import Common.Utils exposing (combineMsgs, setFocus)
import Common.View exposing (getPageHeader)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Http
import RemoteData exposing (RemoteData)
import Route exposing (Route, routeToString)
import Task exposing (Task)
import Types exposing (..)


update : Msg -> LoginModel -> Context -> ( LoginModel, Cmd Msg )
update msg loginModel context =
    case msg of
        SetRoute Route.Login ->
            ( loginModel, setFocus "email1" )

        LogoClick ->
            ( loginModel, pushUrl context.key (routeToString Route.Home) )

        LoginUpdateEmail email ->
            handleLoginUpdateEmail email loginModel

        LoginUpdatePassword password ->
            handleLoginUpdatePassword password loginModel

        LoginSubmit ->
            handleLoginSubmit loginModel

        AuthenticateComplete result ->
            handleAuthenticateComplete result loginModel context

        GotTokenResponse (RemoteData.Success (Just token)) ->
            ( loginModel, Api.whoami token )

        GotUserResponse (RemoteData.Success (Just user)) ->
            handleAuthenticateOk user loginModel context

        _ ->
            ( loginModel, Cmd.none )


view : LoginModel -> Context -> Html Msg
view loginModel context =
    div [ class "login-page" ]
        [ getPageHeader context
        , Html.form [ onSubmit NoOp ]
            [ div [ class "form-group" ]
                [ input
                    [ type_ "email"
                    , class "form-control"
                    , id "email1"
                    , placeholder "Email"
                    , value loginModel.email
                    , name "email"
                    , onInput LoginUpdateEmail
                    ]
                    []
                ]
            , div [ class "form-group" ]
                [ input
                    [ type_ "password"
                    , class "form-control"
                    , id "password1"
                    , value loginModel.password
                    , placeholder "Password"
                    , name "password"
                    , onInput LoginUpdatePassword
                    ]
                    []
                ]
            , div [ class "form-check" ] []
            , button
                [ class "btn"
                , disabled (not loginModel.valid)
                , onClick LoginSubmit
                ]
                [ text "Submit" ]
            ]
        ]


handleLoginUpdateEmail : Email -> LoginModel -> ( LoginModel, Cmd Msg )
handleLoginUpdateEmail email loginModel =
    let
        newLoginModel =
            { loginModel | email = email }

        valid =
            validate newLoginModel
    in
    ( { newLoginModel | valid = valid }
    , Cmd.none
    )


handleLoginUpdatePassword : Password -> LoginModel -> ( LoginModel, Cmd Msg )
handleLoginUpdatePassword password loginModel =
    let
        newLoginModel =
            { loginModel | password = password }

        valid =
            validate newLoginModel
    in
    ( { newLoginModel | valid = valid }
    , Cmd.none
    )


handleLoginSubmit : LoginModel -> ( LoginModel, Cmd Msg )
handleLoginSubmit loginModel =
    let
        { email, password } =
            loginModel
    in
    ( { loginModel | submitted = True, request = RemoteData.Loading }
    , Api.exchangeCredentialsForToken email password
    )


handleAuthenticateComplete : Result AuthenticateError User -> LoginModel -> Context -> ( LoginModel, Cmd Msg )
handleAuthenticateComplete result loginModel context =
    case result of
        Ok user ->
            handleAuthenticateOk user loginModel context

        Err err ->
            handleAuthenticateErr err loginModel


handleAuthenticateOk : User -> LoginModel -> Context -> ( LoginModel, Cmd Msg )
handleAuthenticateOk user loginModel context =
    let
        token =
            case context.token of
                Just value ->
                    value

                _ ->
                    ""
    in
    ( { loginModel | submitted = False, email = "", password = "", valid = False }
    , combineMsgs
        [ Api.setupSubscriptions token
        , Api.incrementCountBy token 0
        ]
    )



-- http://package.elm-lang.org/packages/elm-lang/http/1.0.0/Http#Error
-- type Error
--     = BadUrl String
--     | Timeout
--     | NetworkError
--     | BadStatus (Response String)
--     | BadPayload String (Response String)
--
--     A Request can fail in a couple ways:
--
--         BadUrl means you did not provide a valid URL.
--         Timeout means it took too long to get a response.
--         NetworkError means the user turned off their wifi, went in a cave, etc.
--         BadStatus means you got a response back, but the status code indicates failure.
--         BadPayload means you got a response back with a nice status code, but the body of
--             the response was something unexpected. The String in this case is a debugging
--             message that explains what went wrong with your JSON decoder or whatever.


handleAuthenticateErr : AuthenticateError -> LoginModel -> ( LoginModel, Cmd Msg )
handleAuthenticateErr err loginModel =
    ( { loginModel | submitted = False }
    , Cmd.none
    )


validate : LoginModel -> Bool
validate loginModel =
    validateEmail loginModel.email
        && validatePassword loginModel.password


validateEmail : Email -> Bool
validateEmail email =
    String.contains "@" email
        && String.contains "." email


validatePassword : Password -> Bool
validatePassword password =
    String.length password >= 1
