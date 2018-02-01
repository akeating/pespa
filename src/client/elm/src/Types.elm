module Types exposing (..)

import Route exposing (Route)
import Navigation exposing (Location)
import Http
import Dom
import Api.Object exposing (CounterState)
import Graphqelm.Subscription


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
    , graphqlSubscriptionModel : Graphqelm.Subscription.Model Msg (Maybe CounterState)
    , subscriptionStatus : Graphqelm.Subscription.Status
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
    { version: Int
    , count: Int
    }

type Msg
    = Logout
    | FocusResult (Result Dom.Error ())
    | UrlChange Location
    | SetRoute Route
    | LoginSubmit
    | LoginUpdateEmail Email
    | LoginUpdatePassword Password
    | AuthenticateComplete (Result Http.Error User)
    | ApiNetworkError
    | SnackBarTimeout
    | LogoClick
    | GraphqlSubscriptionMsg (Graphqelm.Subscription.Msg (Maybe CounterState))
    | SubscriptionDataReceived (Maybe CounterState)
    | SubscriptionStatusChanged Graphqelm.Subscription.Status
