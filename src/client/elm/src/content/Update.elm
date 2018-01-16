module Content.Update exposing (update)

import Types exposing (..)


update : Msg -> ContentModel -> Context -> (ContentModel, Cmd Msg)
update msg contentModel context =
    ( contentModel, Cmd.none )
