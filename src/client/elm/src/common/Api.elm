module Common.Api exposing (exchangeCredentialsForToken, whoami)

import Auto.Object
import Auto.Object.User
import Auto.Query
import Graphql.Http
import Graphql.Operation exposing (RootMutation, RootQuery)
import Graphql.SelectionSet as SelectionSet exposing (SelectionSet, hardcoded, with)
import RemoteData exposing (RemoteData)
import Types as Types exposing (Msg(..), User)


exchangeCredentialsForToken : String -> String -> Cmd Msg
exchangeCredentialsForToken email password =
    exchangeCredentialsForTokenQuery email password
        |> Graphql.Http.queryRequest "http://localhost:3000/api/graphql"
        |> Graphql.Http.send (RemoteData.fromResult >> GotTokenResponse)


exchangeCredentialsForTokenQuery : String -> String -> SelectionSet (Maybe String) RootQuery
exchangeCredentialsForTokenQuery email password =
    Auto.Query.exchangeCredentialsForToken { email = email, password = password }


whoami : String -> Cmd Msg
whoami token =
    whoamiQuery token
        |> Graphql.Http.queryRequest "http://localhost:3000/api/graphql"
        |> Graphql.Http.withHeader "authorization" token
        |> Graphql.Http.send (RemoteData.fromResult >> GotUserResponse)


whoamiQuery : String -> SelectionSet (Maybe User) RootQuery
whoamiQuery token =
    Auto.Query.whoami <|
        SelectionSet.map3 Types.User
            Auto.Object.User.id
            Auto.Object.User.email
            Auto.Object.User.name
