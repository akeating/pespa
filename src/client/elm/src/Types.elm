module Types exposing (AuthenticateError(..), ContentModel, Context, CounterState, Email, FrameModel, HomeModel, LoginModel, Model, Msg(..), Password, SnackBarModel, SubscriptionStatus(..), Token, TokenResponse, User, UserResponse)

import Browser exposing (UrlRequest)
import Browser.Dom exposing (Error)
import Browser.Navigation exposing (Key)
import Graphql.Http
import Json.Decode
import RemoteData exposing (RemoteData)
import Result
import Route exposing (Route)
import Url exposing (Url)


type alias Email =
    String


type alias Password =
    String


type alias Token =
    String


type alias User =
    { id : Int
    , email : Email
    , name : String
    }


type alias Context =
    { key : Key
    , url : Url
    , user : Maybe User
    , subscriptionStatus : SubscriptionStatus
    , token : Maybe Token
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
    { count : Maybe Int
    }


type alias LoginModel =
    { email : Email
    , password : Password
    , valid : Bool
    , submitted : Bool
    , request : UserResponse
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


type alias TokenResponse =
    GraphqlData (Maybe Token)


type alias UserResponse =
    GraphqlData (Maybe User)


type alias GraphqlData value =
    RemoteData (Graphql.Http.Error value) value


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
    | SubscriptionDataReceived Json.Decode.Value
    | NewSubscriptionStatus SubscriptionStatus ()
    | GotTokenResponse TokenResponse
    | GotUserResponse UserResponse


type SubscriptionStatus
    = NotConnected
    | Connected
    | Reconnecting
