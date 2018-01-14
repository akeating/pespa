module Main exposing (main)

import Html
import Navigation
import State exposing (init, update)
import View exposing (view)
import Types exposing (..)

main =
    Navigation.program UrlChange
        { init = init
        , update = update
        , view = view
        , subscriptions = always Sub.none
        }
