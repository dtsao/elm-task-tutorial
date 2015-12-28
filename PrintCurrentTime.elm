module Main (..) where

import Graphics.Element exposing (show)
import Task exposing (Task, andThen)
import TaskTutorial exposing (getCurrentTime, print)


port runner : Task x ()
port runner =
    getCurrentTime `andThen` (\time -> print time)


main =
    show "Open the Developer Console of your browser."
