module Example exposing (..)

import Expect exposing (Expectation)
import Fuzz exposing (Fuzzer, list, int, string)
import Test exposing (..)
import Test.Html.Query as Query
import Test.Html.Selector exposing (text, tag)
import App exposing (..)


{-| See <https://github.com/elm-community/elm-test>
-}
-- unitTest : Test
-- unitTest =
--     describe "simple unit test"
--         [ test "Inc adds one" <|
--             \() ->
--                 update Inc 0
--                     |> Tuple.first
--                     |> Expect.equal 1
--         ]


{-| See <https://github.com/elm-community/elm-test>
-}
-- fuzzTest : Test
-- fuzzTest =
--     describe "simple fuzz test"
--         [ fuzz int "Inc ALWAYS adds one" <|
--             \model ->
--                 update Inc model
--                     |> Tuple.first
--                     |> Expect.equal (model + 1)
--         ]


{-| see <https://github.com/eeue56/elm-html-test>
-}
-- viewTest : Test
-- viewTest =
--     describe "Testing view function"
--         [ test "Button has the expected text" <|
--             \() ->
--                 view 0
--                     |> Query.fromHtml
--                     |> Query.find [ tag "button" ]
--                     |> Query.has [ text "+ 1" ]
--         ]
