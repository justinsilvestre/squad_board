module UpdateMouse exposing (..)

import Message exposing (..)
import Model exposing (..)


updateMouse : Message -> MouseState -> MouseState
updateMouse message model =
    case message of
        DragOverSquad squadId ->
            { model | dragEnterSquadId = Just squadId }

        DragTeamMember maybeId ->
            { model | draggedTeamMemberId = maybeId }

        _ ->
            model
