module Utils.Events exposing (..)

import Html
import Html.Events
import Json.Decode
import Message exposing (Message)


onDragStart : Message -> Html.Attribute Message
onDragStart message =
    Html.Events.on "dragstart" (Json.Decode.succeed message)


onDragEnd : Message -> Html.Attribute Message
onDragEnd message =
    Html.Events.on "dragend" (Json.Decode.succeed message)


onDragOver : Message -> Html.Attribute Message
onDragOver message =
    Html.Events.onWithOptions "dragover" { preventDefault = True, stopPropagation = False } (Json.Decode.succeed message)


onDrop : Message -> Html.Attribute Message
onDrop message =
    Html.Events.on "drop" (Json.Decode.succeed message)
