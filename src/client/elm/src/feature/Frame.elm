module Feature.Frame exposing (update, view)

import Common.Utils exposing (combineMsgs)
import Feature.Frame.SnackBar as SnackBar
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Types exposing (..)


update : Msg -> FrameModel -> Context -> ( FrameModel, Cmd Msg )
update msg frameModel context =
    let
        { snackBarModel } =
            frameModel

        ( newSnackBarModel, snackBarMsg ) =
            SnackBar.update msg snackBarModel context
    in
    ( { frameModel | snackBarModel = newSnackBarModel }
    , combineMsgs [ snackBarMsg ]
    )


view : FrameModel -> Context -> Html Msg -> Html Msg
view frameModel context page =
    let
        buttonDisabled =
            case context.user of
                Nothing ->
                    False

                _ ->
                    True

        user =
            User 1 "user@example.com" "Adam Keating"
    in
    div [ class "frame" ]
        [ div [ class "header" ]
            [ button
                [ class "btn"
                , disabled buttonDisabled
                , onClick (AuthenticateComplete (Ok user))
                ]
                [ text ("Login " ++ user.email) ]
            , button
                [ class "btn"
                , onClick ApiNetworkError
                ]
                [ text "Simulate ApiNetworkError" ]
            ]
        , div [ class "page" ]
            [ SnackBar.view frameModel.snackBarModel
            , page
            ]
        ]
