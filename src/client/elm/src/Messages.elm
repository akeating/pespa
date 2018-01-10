module Messages exposing (..)

import Navigation exposing (Location)


type Msg
    = UrlChange Location
    | NewUrl String
