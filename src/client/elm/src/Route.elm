module Route exposing (Route(..), fromUrl, href, routeToString)

import Browser.Navigation
import Html exposing (Attribute)
import Html.Attributes as Attr
import Url exposing (Url)
import Url.Parser as Url exposing ((</>), Parser, oneOf, parse, s, string, top)



-- ROUTING --


type Route
    = Home
    | Login
    | Content


route : Parser (Route -> a) a
route =
    oneOf
        [ Url.map Home top
        , Url.map Login (s "login")
        , Url.map Content (s "a")
        ]



-- INTERNAL --


routeToString : Route -> String
routeToString rte =
    let
        pieces =
            case rte of
                Home ->
                    []

                Login ->
                    [ "login" ]

                Content ->
                    [ "a" ]
    in
    "/" ++ String.join "/" pieces



-- PUBLIC HELPERS --


href : Route -> Attribute msg
href rte =
    Attr.href (routeToString rte)


fromUrl : Url -> Maybe Route
fromUrl url =
    parse route url
