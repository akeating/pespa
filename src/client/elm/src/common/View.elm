module Common.View exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Types exposing (..)


preventDefault : String -> Attribute Msg
preventDefault event =
    attribute event "event.preventDefault(); event.stopImmediatePropagation();"
