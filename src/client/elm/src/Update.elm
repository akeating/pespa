module Update exposing (update)

import Route exposing (routeToString)
import Browser.Navigation exposing (pushUrl)
import Types exposing (..)
import Tasks exposing (authenticate)
import Feature.Frame as Frame
import Feature.Home as Home
import Feature.Login as Login
import Feature.Content as Content
import Common.Utils exposing (combineMsgs)


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    let
        { context, homeModel, contentModel, loginModel, frameModel } = model
        ( newModel, rootMsg ) = rootUpdate msg model
        ( newContext, contextMsg ) = contextUpdate msg context
        ( newFrameModel, frameMsg ) = Frame.update msg frameModel context
        ( newHomeModel, homeMsg ) = Home.update msg homeModel context
        ( newLoginModel, loginMsg ) = Login.update msg loginModel context
        ( newContentModel, contentMsg ) = Content.update msg contentModel context
        updateModel = combineModels newModel newContext newHomeModel newLoginModel newContentModel newFrameModel
        updateMsg = combineMsgs [rootMsg, contextMsg, frameMsg, homeMsg, loginMsg, contentMsg]
    in
        ( updateModel, updateMsg )


rootUpdate : Msg -> Model -> (Model, Cmd Msg)
rootUpdate msg model =
    let
        { context, homeModel, contentModel, loginModel } = model
    in
        case msg of
            SetRoute route ->
                ( model, pushUrl context.key (routeToString route) )

            AuthenticateComplete (Ok user) ->
                ( model, pushUrl context.key (routeToString Route.Content) )

            _ ->
                ( model, Cmd.none )


contextUpdate : Msg -> Context -> (Context, Cmd Msg)
contextUpdate msg context =
    case msg of
        UrlChange url ->
            ( { context | url = url }
            , Cmd.none
            )

        AuthenticateComplete (Ok user) ->
            ( { context | user = Just user }
            , Cmd.none
            )

        Logout ->
            ( { context | user = Nothing }
            , pushUrl context.key (routeToString Route.Home)
            )

        _ ->
            ( context, Cmd.none )


combineModels : Model -> Context -> HomeModel -> LoginModel -> ContentModel -> FrameModel -> Model
combineModels model context homeModel loginModel contentModel frameModel =
    { model
    | context = context
    , homeModel = homeModel
    , loginModel = loginModel
    , contentModel = contentModel
    , frameModel = frameModel
    }
