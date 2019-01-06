module View exposing (view)

import Browser exposing (Document)
import Feature.Content as Content
import Feature.Frame as Frame
import Feature.Home as Home
import Feature.Login as Login
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Route exposing (Route, fromUrl)
import Types exposing (..)


view : Model -> Document Msg
view model =
    let
        { context, homeModel, contentModel, loginModel, frameModel } =
            model

        maybeRoute =
            fromUrl context.url

        body =
            case maybeRoute of
                Just Route.Login ->
                    Frame.view frameModel context (Login.view loginModel context)

                Just Route.Home ->
                    Frame.view frameModel context (Home.view homeModel context)

                Just Route.Content ->
                    Frame.view frameModel context (Content.view contentModel context)

                _ ->
                    Frame.view frameModel context (Home.view homeModel context)
    in
    { title = "Elm client"
    , body = [ body ]
    }
