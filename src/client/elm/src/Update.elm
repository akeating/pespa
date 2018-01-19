module Update exposing (update)

import Route exposing (modifyUrl)
import Types exposing (..)
import Tasks exposing (authenticate)
import Common.SnackBar as SnackBar
import Feature.Home as Home
import Feature.Login as Login
import Feature.Content as Content


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    let
        { context, homeModel, contentModel, loginModel, snackBarModel } = model
        ( newModel, rootMsg ) = rootUpdate msg model
        ( newContext, contextMsg ) = contextUpdate msg context
        ( newSnackBarModel, snackBarMsg ) = SnackBar.update msg snackBarModel context
        ( newHomeModel, homeMsg ) = Home.update msg homeModel context
        ( newLoginModel, loginMsg ) = Login.update msg loginModel context
        ( newContentModel, contentMsg ) = Content.update msg contentModel context
        updateModel = combineModels newModel newContext newHomeModel newLoginModel newContentModel newSnackBarModel
        updateMsg = combineMsgs [rootMsg, contextMsg, homeMsg, loginMsg, contentMsg]
    in
        ( updateModel, updateMsg )


rootUpdate : Msg -> Model -> (Model, Cmd Msg)
rootUpdate msg model =
    let
        { context, homeModel, contentModel, loginModel } = model
    in
        case msg of
            SetRoute route ->
                ( model, modifyUrl route )

            AuthenticateComplete (Ok user) ->
                ( model, modifyUrl Route.Content )

            _ ->
                ( model, Cmd.none )


contextUpdate : Msg -> Context -> (Context, Cmd Msg)
contextUpdate msg context =
    case msg of
        UrlChange location ->
            ( { context | location = location }
            , Cmd.none
            )

        AuthenticateComplete (Ok user) ->
            ( { context | user = Just user }
            , Cmd.none
            )

        _ ->
            ( context, Cmd.none )


combineModels : Model -> Context -> HomeModel -> LoginModel -> ContentModel -> SnackBarModel -> Model
combineModels model context homeModel loginModel contentModel snackBarModel =
    { model
    | context = context
    , homeModel = homeModel
    , loginModel = loginModel
    , contentModel = contentModel
    }


combineMsgs : List (Cmd Msg) -> Cmd Msg
combineMsgs msgs =
    Cmd.batch msgs
