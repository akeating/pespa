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
        , onUrlRequest = onUrlRequest
        , onUrlChange = onUrlChange
        }


onUrlRequest : UrlRequest -> Msg
onUrlRequest urlRequest =
    ClickedLink urlRequest


onUrlChange : Url -> Msg
onUrlChange url =
    UrlChange url
