module Main exposing (main)

import Html
import Browser
import Init exposing (init)
import Update exposing (update)
import View exposing (view)
import Types exposing (..)
import Subscriptions exposing (subscriptions)
import Browser exposing (UrlRequest)
import Url exposing (Url)

main =
    Browser.application
        { init = init
        , update = update
        , view = view
        , subscriptions = subscriptions
        , onUrlRequest = onUrlRequest
        , onUrlChange = onUrlChange
        }

onUrlRequest : UrlRequest -> Msg
onUrlRequest urlRequest =
    ClickedLink urlRequest

onUrlChange : Url -> Msg
onUrlChange url =
    UrlChange url
