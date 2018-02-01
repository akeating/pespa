module Init exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Navigation exposing (Location, newUrl)
import Route exposing (modifyUrl, fromLocation)
import Types exposing (..)
import Api.Object
import Api.Object.CounterState
import Api.Subscription
import Graphqelm.Operation exposing (RootMutation, RootSubscription)
import Graphqelm.SelectionSet exposing (with)
import Graphqelm.Subscription
import Graphqelm.Subscription.Protocol exposing (Protocol)


init : Location -> ( Model, Cmd Msg )
init location =
    let
        ( graphqlSubscriptionModel, graphqlSubscriptionCmd ) =
            Graphqelm.Subscription.init Graphqelm.Subscription.Protocol.phoenixAbsinthe socketUrl subscriptionDocument SubscriptionDataReceived
        route = fromLocation location
    in
        case route of
            _ ->
                ({ context =
                    { location = location
                    , user = Nothing
                    }
                 , homeModel = Nothing
                 , contentModel = Nothing
                 , loginModel =
                     { email = ""
                     , password = ""
                     , valid = False
                     , submitted = False
                     }
                 , frameModel =
                     { snackBarModel =
                         { showSnack = False
                         }
                     }
                 , graphqlSubscriptionModel =
                     graphqlSubscriptionModel |> Graphqelm.Subscription.onStatusChanged SubscriptionStatusChanged
                 , subscriptionStatus = Graphqelm.Subscription.Uninitialized
                 , counterState = Nothing
                 }
                 , Cmd.batch [modifyUrl Route.Home, graphqlSubscriptionCmd])


subscriptionDocument : Graphqelm.SelectionSet.SelectionSet (Maybe CounterState) RootSubscription
subscriptionDocument =
    Api.Subscription.selection identity
        |> with (Api.Subscription.countChanged counterStateSelection)


counterStateSelection : Graphqelm.SelectionSet.SelectionSet CounterState Api.Object.CounterState
counterStateSelection =
    Api.Object.CounterState.selection CounterState
        |> with Api.Object.CounterState.version
        |> with Api.Object.CounterState.count


socketUrl : String
socketUrl =
    "ws://localhost:3000/socket/websocket?vsn=2.0.0"
