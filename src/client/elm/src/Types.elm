module Types exposing (..)

import Route exposing (Route)
import Navigation exposing (Location)
import Http


type alias Email = String

type alias Password = String

type alias User =
    { email : Email
    }

type alias Context =
    { location : Location
    , user : Maybe User
    }

type alias Model =
    { context: Context
    , homeModel : HomeModel
    , contentModel : ContentModel
    , loginModel : LoginModel
    , snackBarModel : SnackBarModel
    }

type alias HomeModel =
    Maybe String

type alias ContentModel =
    Maybe String

type alias LoginModel =
    { email : Email
    , password : Password
    , valid : Bool
    , submitted : Bool
    }

type alias SnackBarModel =
    { showSnack : Bool
    }

type Msg
    = UrlChange Location
    | SetRoute Route
    | LoginSubmit
    | LoginUpdateEmail Email
    | LoginUpdatePassword Password
    | AuthenticateComplete (Result Http.Error User)
    | ApiNetworkError
