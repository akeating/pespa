module Types exposing (..)

import Route exposing (Route)
import Navigation exposing (Location)
import Http
import Dom


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
    , frameModel : FrameModel
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

type alias FrameModel =
    { snackBarModel : SnackBarModel
    }

type alias SnackBarModel =
    { showSnack : Bool
    }

type Msg
    = FocusResult (Result Dom.Error ())
    | UrlChange Location
    | SetRoute Route
    | LoginSubmit
    | LoginUpdateEmail Email
    | LoginUpdatePassword Password
    | AuthenticateComplete (Result Http.Error User)
    | ApiNetworkError
    | SnackBarTimeout
    | LogoClick
