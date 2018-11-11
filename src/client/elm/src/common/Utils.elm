module Common.Utils exposing (..)

import Types exposing (..)
import Task
import Process
import Time
import Browser.Dom exposing (focus)


combineMsgs : List (Cmd Msg) -> Cmd Msg
combineMsgs msgs =
    Cmd.batch msgs


delay : Int -> Msg -> Cmd Msg
delay milliSeconds msg =
  Process.sleep (toFloat milliSeconds)
  |> Task.perform (always msg)


setFocus : String -> Cmd Msg
setFocus id =
    Task.attempt FocusResult (focus id)
