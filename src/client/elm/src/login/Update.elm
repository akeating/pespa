module Login.Update exposing (update)

import Types exposing (..)
import Tasks exposing (authenticate)


update : Msg -> LoginModel -> Context -> (LoginModel, Cmd Msg)
update msg loginModel context =
    let
        { email, password, valid, submitted } = loginModel
    in
        case msg of
            LoginUpdateEmail email ->
                let
                    newLoginModel = { loginModel | email = email }
                    valid = validate newLoginModel
                in
                    ({ newLoginModel | valid = valid }
                    , Cmd.none)

            LoginUpdatePassword password ->
                let
                    newLoginModel = { loginModel | password = password }
                    valid = validate newLoginModel
                in
                    ({ newLoginModel | valid = valid }
                    , Cmd.none)

            LoginSubmit ->
                ( { loginModel | submitted = True }
                , authenticate loginModel.email loginModel.password AuthenticateComplete )

            AuthenticateComplete (Ok user) ->
                ( { loginModel | submitted = False, email = "", password = "", valid = False }
                , Cmd.none )

            AuthenticateComplete (Err err) ->
                ( { loginModel | submitted = False }
                , Cmd.none )

            _ ->
                ( loginModel, Cmd.none )


validate : LoginModel -> Bool
validate loginModel =
    validateEmail loginModel.email &&
    validatePassword loginModel.password


validateEmail: Email -> Bool
validateEmail email =
    String.contains "@" email &&
    String.contains "." email


validatePassword: Password -> Bool
validatePassword password =
    String.length password >= 8
