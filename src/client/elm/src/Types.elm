module Types exposing (AuthenticateError(..), ContentModel, Context, CounterState, Email, FrameModel, HomeModel, LoginModel, Model, Msg(..), Password, SnackBarModel, User)

import Browser exposing (UrlRequest)
import Browser.Dom exposing (Error)
import Browser.Navigation exposing (Key)
import Result
import Route exposing (Route)
import Url exposing (Url)


type alias Email =
    String


type alias Password =
    String


type alias User =
    { email : Email
    }


type alias Context =
    { key : Key
    , url : Url
    , user : Maybe User
    }


type alias Model =
    { context : Context
    , homeModel : HomeModel
    , contentModel : ContentModel
    , loginModel : LoginModel
    , frameModel : FrameModel
    , counterState : Maybe CounterState
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


type alias CounterState =
    { version : Int
    , count : Int
    }


type AuthenticateError
    = Bad String
    | Wrong


type Msg
    = Logout
    | FocusResult (Result Error ())
    | UrlChange Url
    | ClickedLink UrlRequest
    | SetRoute Route
    | LoginSubmit
    | LoginUpdateEmail Email
    | LoginUpdatePassword Password
    | AuthenticateComplete (Result AuthenticateError User)
    | ApiNetworkError
    | SnackBarTimeout
    | LogoClick
    | NoOp
