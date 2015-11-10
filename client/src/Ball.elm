module Ball where

import Color exposing (..)
import Graphics.Collage exposing (..)
import Graphics.Element exposing (..)

acceleration : Float
acceleration = 0.2

resistance : Float
resistance = 0.1

resist : Float -> Float
resist v = if abs(v) <= resistance
           then 0
           else v - v/abs(v) * resistance

type alias Position = { x : Float
                      , y : Float
                      }

type alias Speed = { vx : Float
                   , vy : Float
                   }

type alias Ball =
  { position : Position
  , speed : Speed
  }

initPosition : Position
initPosition = { x = 10
               , y = 10
               }

initSpeed : Speed
initSpeed = { vx = 0
            , vy = 0
            }

init : Ball
init = { position = initPosition
       , speed = initSpeed
       }

update : { x : Int, y : Int} -> Ball -> Ball
update {x,y} {speed, position} = { speed = 
                                    { speed | vx = resist <| speed.vx + acceleration * toFloat x
                                            , vy = resist <| speed.vy + acceleration * toFloat y
                                    }
                                 , position =
                                    { position | x = position.x + speed.vx   -- FIXME: position will be updated with old speed.
                                               , y = position.y + speed.vy
                                    }
                                 }

view : (Int, Int) -> Ball -> Element
view (w,h) {position} = 
  container w h middle <|
    collage w h
    [ oval 10 10 |> filled black |> move (position.x, position.y)
    ]
