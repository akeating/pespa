module Feature.Frame exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Types exposing (..)
import Feature.Frame.SnackBar as SnackBar


update : Msg -> FrameModel -> Context -> (FrameModel, Cmd Msg)
update msg frameModel context =
    let
        { snackBarModel } = frameModel
        ( newSnackBarModel, snackBarMsg ) = SnackBar.update msg snackBarModel context
    in
        ( { frameModel | snackBarModel = newSnackBarModel }
        , Cmd.none )


view : FrameModel -> Html Msg -> Html Msg
view frameModel page =
    (div [ class "frame" ]
        [ div [ class "header" ]
            [ button [ class "btn"
                     , onClick ApiNetworkError
                     ] [ text "Simulate ApiNetworkError" ]
            ]
        , div [ class "page" ]
            [ SnackBar.view frameModel.snackBarModel
            , page ]
        ])
