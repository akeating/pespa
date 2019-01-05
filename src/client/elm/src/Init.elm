module Init exposing (init)

import Auto.Object
import Auto.Object.CounterState
import Auto.Subscription
import Browser.Navigation exposing (Key, pushUrl)
import Graphql.Document
import Graphql.Operation exposing (RootSubscription)
import Graphql.SelectionSet as SelectionSet exposing (SelectionSet, map2, with)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Ports exposing (createSubscriptions)
import RemoteData exposing (RemoteData)
import Route exposing (fromUrl, routeToString)
import Types as Types exposing (CounterState, Model, SubscriptionStatus(..))
import Url exposing (Url)


init : () -> Url -> Key -> ( Model, Cmd msg )
init flags url key =
    let
        route =
            fromUrl url
    in
    case route of
        _ ->
            ( { context =
                    { key = key
                    , url = url
                    , user = Nothing
                    , subscriptionStatus = NotConnected
                    , token = Nothing
                    }
              , homeModel = Nothing
              , contentModel = Nothing
              , loginModel =
                    { email = "demo@example.com"
                    , password = "foo"
                    , valid = True
                    , submitted = False
                    , request = RemoteData.NotAsked
                    }
              , frameModel =
                    { snackBarModel =
                        { showSnack = False
                        }
                    }
              , counterState = Nothing
              }
            , Cmd.batch
                [ createSubscriptions (subscriptionDocument |> Graphql.Document.serializeSubscription)
                , pushUrl key (routeToString Route.Home)
                ]
            )


subscriptionDocument : SelectionSet (Maybe Types.CounterState) RootSubscription
subscriptionDocument =
    Auto.Subscription.countChanged
        (SelectionSet.map2 Types.CounterState
            Auto.Object.CounterState.version
            Auto.Object.CounterState.count
        )



-- socketUrl : String
-- socketUrl =
--     "ws://localhost:3000/socket/websocket?vsn=2.0.0"
