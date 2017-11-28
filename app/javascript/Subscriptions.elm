module Subscriptions exposing (..)

import Model exposing (..)
import Message exposing (..)


-- import Mouse


convert : a -> Message
convert a =
    SetText (toString a)


subscriptions : Model -> Sub Message
subscriptions model =
    Sub.batch
        [-- Mouse.moves convert
         -- , Mouse.moves MoveMouse
        ]
