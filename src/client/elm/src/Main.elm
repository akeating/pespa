module Main exposing (main)

import Html
import Navigation
import App exposing (init, update, view)
import Messages exposing (..)

main =
    Navigation.program UrlChange
        { init = init
        , update = update
        , view = view
        , subscriptions = always Sub.none
        }
