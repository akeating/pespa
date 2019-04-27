-- Do not manually edit this file, it was auto-generated by dillonkearns/elm-graphql
-- https://github.com/dillonkearns/elm-graphql


module Auto.Subscription exposing (countChanged)

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
import Json.Decode as Decode exposing (Decoder)


countChanged : SelectionSet decodesTo Auto.Object.CounterState -> SelectionSet (Maybe decodesTo) RootSubscription
countChanged object_ =
    Object.selectionForCompositeField "countChanged" [] object_ (identity >> Decode.nullable)