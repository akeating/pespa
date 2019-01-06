module Common.Api exposing (exchangeCredentialsForToken, setupSubscriptions, unpackSubscriptionData, whoami)

import Auto.Object
import Auto.Object.CounterState
import Auto.Object.User
import Auto.Query
import Auto.Subscription
import Graphql.Document
import Graphql.Http
import Graphql.Operation exposing (RootMutation, RootQuery, RootSubscription)
import Graphql.SelectionSet as SelectionSet exposing (SelectionSet, hardcoded, map2, with)
import Json.Decode
import Ports exposing (createSubscriptions)
import RemoteData exposing (RemoteData)
import Types as Types exposing (CounterState, Msg(..), Token, User)


exchangeCredentialsForToken : String -> String -> Cmd Msg
exchangeCredentialsForToken email password =
    exchangeCredentialsForTokenQuery email password
        |> Graphql.Http.queryRequest "/api/graphql"
        |> Graphql.Http.send (RemoteData.fromResult >> GotTokenResponse)


exchangeCredentialsForTokenQuery : String -> String -> SelectionSet (Maybe String) RootQuery
exchangeCredentialsForTokenQuery email password =
    Auto.Query.exchangeCredentialsForToken { email = email, password = password }


whoami : String -> Cmd Msg
whoami token =
    whoamiQuery token
        |> Graphql.Http.queryRequest "/api/graphql"
        |> Graphql.Http.withHeader "authorization" token
        |> Graphql.Http.send (RemoteData.fromResult >> GotUserResponse)


whoamiQuery : String -> SelectionSet (Maybe User) RootQuery
whoamiQuery token =
    Auto.Query.whoami <|
        SelectionSet.map3 Types.User
            Auto.Object.User.id
            Auto.Object.User.email
            Auto.Object.User.name


setupSubscriptions : Token -> Cmd Msg
setupSubscriptions token =
    let
        query =
            subscriptionDocument |> Graphql.Document.serializeSubscription
    in
    createSubscriptions ( token, query )


subscriptionDocument : SelectionSet (Maybe Types.CounterState) RootSubscription
subscriptionDocument =
    Auto.Subscription.countChanged
        (SelectionSet.map2 Types.CounterState
            Auto.Object.CounterState.version
            Auto.Object.CounterState.count
        )


unpackSubscriptionData : Msg -> Maybe CounterState
unpackSubscriptionData msg =
    case msg of
        SubscriptionDataReceived newData ->
            case Json.Decode.decodeValue (subscriptionDocument |> Graphql.Document.decoder) newData of
                Ok counterState ->
                    counterState

                Err _ ->
                    Nothing

        _ ->
            Nothing
