-- Do not manually edit this file, it was auto-generated by dillonkearns/elm-graphql
-- https://github.com/dillonkearns/elm-graphql


module Auto.Object.CounterState exposing (count, version)

import Auto.InputObject
import Auto.Interface
import Auto.Object
import Auto.Scalar
import Auto.Union
import Graphql.Internal.Builder.Argument as Argument exposing (Argument)
import Graphql.Internal.Builder.Object as Object
import Graphql.Internal.Encode as Encode exposing (Value)
import Graphql.Operation exposing (RootMutation, RootQuery, RootSubscription)
import Graphql.OptionalArgument exposing (OptionalArgument(..))
import Graphql.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode


count : SelectionSet Int Auto.Object.CounterState
count =
    Object.selectionForField "Int" "count" [] Decode.int


version : SelectionSet Int Auto.Object.CounterState
version =
    Object.selectionForField "Int" "version" [] Decode.int
