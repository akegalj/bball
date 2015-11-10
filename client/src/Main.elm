import Ball exposing (init, update, view, Ball)
import Keyboard
import Window
import Time exposing (..)

-- main : Signal Element
main = Signal.map2 view Window.dimensions ballState

ballState : Signal Ball
ballState = Signal.foldp update init input

delta = Signal.map inSeconds (fps 35)

input : Signal.Signal { x:Int, y:Int }
input = Signal.sampleOn delta <| Keyboard.arrows
