module Home.Update exposing (update)

import Types exposing (..)


update : Msg -> HomeModel -> Context -> (HomeModel, Cmd Msg)
update msg homeModel context =
    ( homeModel, Cmd.none )
