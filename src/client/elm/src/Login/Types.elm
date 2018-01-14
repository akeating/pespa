module Login.Types exposing (..)


type alias Model =
    { email : String
    , password : String
    }


type Msg
    = Submit
    | UpdateEmail String
    | UpdatePassword String
