module Common.Utils exposing (..)

import Types exposing (..)
import Task
import Process
import Time exposing (Time)
import Dom exposing (Id, focus)


combineMsgs : List (Cmd Msg) -> Cmd Msg
combineMsgs msgs =
    Cmd.batch msgs


delay : Time -> Msg -> Cmd Msg
delay time msg =
  Process.sleep time
  |> Task.perform (always msg)


setFocus : Id -> Cmd Msg
setFocus id =
    Task.attempt FocusResult (focus id)
