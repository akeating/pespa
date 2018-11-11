module Common.Utils exposing (combineMsgs, delay, setFocus)

import Browser.Dom exposing (focus)
import Process
import Task
import Time
import Types exposing (..)


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
