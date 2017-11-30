module UpdateTeamMembersTray exposing (..)

import Message exposing (..)
import Model exposing (..)


updateTeamMembersTray : Message -> TeamMembersTray -> TeamMembersTray
updateTeamMembersTray message model =
    case message of
        OpenTrayMenu ->
            { model | isOpen = True }

        CloseTrayMenu ->
            { model | isOpen = False }

        AddTeamMemberToTray id ->
            { model | teamMemberIds = model.teamMemberIds ++ [ id ], isOpen = False }

        RemoveTeamMemberFromTray id ->
            { model | teamMemberIds = List.filter ((/=) id) model.teamMemberIds }

        AddTeamMemberToSquad squadId teamMemberId ->
            { model | teamMemberIds = List.filter ((/=) teamMemberId) model.teamMemberIds }

        _ ->
            model
