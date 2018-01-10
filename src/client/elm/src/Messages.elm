module Messages exposing (..)

import Navigation exposing (Location)
import Route exposing(Route)

type Msg
    = UrlChange Location
    | SetRoute Route
