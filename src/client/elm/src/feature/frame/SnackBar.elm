module Feature.Frame.SnackBar exposing (update, view)

import Common.Utils exposing (delay)
import Graphql.Http
import Graphql.Http.GraphqlError
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import RemoteData exposing (RemoteData)
import Types exposing (..)


update : Msg -> SnackBarModel -> Context -> ( SnackBarModel, Cmd Msg )
update msg snackBarModel context =
    let
        { showSnack } =
            snackBarModel
    in
    case msg of
        GotTokenResponse (RemoteData.Failure error) ->
            case error of
                Graphql.Http.GraphqlError possiblyParsedData errors ->
                    handleError "Unable to login." snackBarModel

                Graphql.Http.HttpError httpError ->
                    handleError "Hmm there was a network issue." snackBarModel

        GotUserResponse (RemoteData.Failure error) ->
            case error of
                Graphql.Http.GraphqlError possiblyParsedData errors ->
                    handleError "Unable to login." snackBarModel

                Graphql.Http.HttpError httpError ->
                    handleError "Hmm there was a network issue." snackBarModel

        SnackBarTimeout ->
            ( { snackBarModel | showSnack = False }
            , Cmd.none
            )

        _ ->
            ( snackBarModel, Cmd.none )


view : SnackBarModel -> Html Msg
view snackBarModel =
    div
        [ class "snack-bar"
        , classList [ ( "show", snackBarModel.showSnack ) ]
        ]
        [ div [ class "snack" ]
            [ text snackBarModel.message ]
        ]


handleError : String -> SnackBarModel -> ( SnackBarModel, Cmd Msg )
handleError message snackBarModel =
    ( { snackBarModel | showSnack = True, message = message }
    , delay 3000 SnackBarTimeout
    )
