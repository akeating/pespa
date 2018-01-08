module App exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Navigation exposing (Location, newUrl)

type alias Model =
    { history : List Location
    }


init : Location -> ( Model, Cmd Msg )
init location =
    ( Model [ location ]
    , Cmd.none
    )



-- UPDATE


type Msg
    = UrlChange Location
    | NewUrl String


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        UrlChange location ->
            ( { model | history = location :: model.history }
            , Cmd.none
            )

        NewUrl url ->
            ( model, newUrl url )



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ ul []
            [ li []
                [ button [ onClick ( NewUrl "/login" ) ] [ text "Login" ] ]
            , li []
                [ button [ onClick ( NewUrl "/home" ) ] [ text "Home" ] ]
            ]
        , ul [] (List.map viewLocation model.history)
        ]

viewLocation : Location -> Html msg
viewLocation location =
    li [] [ text (location.pathname ++ location.hash) ]
