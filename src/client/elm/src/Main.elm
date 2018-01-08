module Main exposing (main)

import Html
import Navigation
import App exposing (init, update, view)

main =
    Navigation.program App.UrlChange
        { init = init
        , update = update
        , view = view
        , subscriptions = always Sub.none
        }
