module Main exposing (main)

import Browser exposing (UrlRequest)
import Html
import Init exposing (init)
import Subscriptions exposing (subscriptions)
import Types exposing (..)
import Update exposing (update)
import Url exposing (Url)
import View exposing (view)


main =
    Browser.application
        { init = init
        , update = update
        , view = view
        , subscriptions = subscriptions
        , onUrlRequest = ClickedLink
        , onUrlChange = UrlChange
        }
