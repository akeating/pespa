module State exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Navigation exposing (Location, newUrl)
import Route exposing (modifyUrl, fromLocation)
import Types exposing (..)
import Home.State
import Login.State
import Content.State
import Login.Types

init : Location -> ( Model, Cmd Msg )
init location =
    let
        route = fromLocation location
    in
        case route of
            _ ->
                ( initialState location
                , modifyUrl Route.Home
                )


initialState : Location -> Model
initialState location =
    { context =
        { location = location
        , user = Nothing
        }
    , home = Home.State.initialState
    , login = Login.State.initialState
    , content = Content.State.initialState
    }


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        UrlChange location ->
            let
                { context } = model
                newContext = { context | location = location }
            in
                ( { model | context = newContext }
                , Cmd.none
                )

        SetRoute route ->
            ( model, modifyUrl route )

        LoginMsg (Login.Types.AuthenticateComplete (Ok user) as subMsg) ->
            let
                { context } = model
                newContext = { context | user = Just user }
                (loginModel, subCmd) = Login.State.update subMsg model.login context
                newModel = { model | login = loginModel, context = newContext }
                commands = Cmd.batch [ Cmd.map LoginMsg subCmd
                                     , modifyUrl Route.Content
                                     ]
            in
                ( { newModel | login = loginModel }
                , commands )

        LoginMsg subMsg ->
            let
                { context } = model
                (loginModel, subCmd) = Login.State.update subMsg model.login context
            in
                ( { model | login = loginModel }
                , Cmd.map LoginMsg subCmd)

        HomeMsg subMsg ->
            ( model, Cmd.none )

        ContentMsg subMsg ->
            ( model, Cmd.none )
