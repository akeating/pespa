module Feature.Frame.SnackBar exposing (update, view)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Types exposing (..)


update : Msg -> SnackBarModel -> Context -> (SnackBarModel, Cmd Msg)
update msg snackBarModel context =
    let
        { showSnack } = snackBarModel
    in
        case msg of
            ApiNetworkError ->
                ( { snackBarModel | showSnack = True }
                , Cmd.none )

            _ ->
                ( snackBarModel, Cmd.none )


view : SnackBarModel -> Html Msg
view snackBarModel =
    (div [ class "snack-bar"
         , classList [ ("show", snackBarModel.showSnack) ]
         ]
         [ div [ class "snack" ]
            [ text "tasty snack" ]
            ])
