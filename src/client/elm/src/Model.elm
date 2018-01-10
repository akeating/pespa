module Model exposing (Model)
import Navigation exposing (Location)


type alias Model =
    { history : List Location
    }
