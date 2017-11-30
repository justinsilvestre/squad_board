module UpdateSquadsList exposing (..)

import Message exposing (..)
import Model exposing (..)


updateSquadsList : Message -> SquadsList -> SquadsList
updateSquadsList message model =
    case message of
        AddSquad ->
            let
                nextSquadId =
                    case model.nextSquadId of
                        NewSquadId int ->
                            NewSquadId (int + 1)

                        -- should never happen
                        Int ->
                            Int

                newSquad =
                    Squad (model.nextSquadId) [] "boop"
            in
                { model
                    | list = model.list ++ [ newSquad ]
                    , nextSquadId = nextSquadId
                }

        AddTeamMemberToSquad squadId teamMemberId ->
            let
                removeMemberFromSquad squad =
                    { squad | teamMembers = List.filter ((/=) teamMemberId) squad.teamMembers }

                appendMemberToRightSquad squad =
                    if squad.id == squadId then
                        { squad | teamMembers = squad.teamMembers ++ [ teamMemberId ] }
                    else
                        squad

                changeSquadMembers squad =
                    squad |> removeMemberFromSquad |> appendMemberToRightSquad
            in
                { model
                    | list = List.map changeSquadMembers model.list
                }

        SetSquadName id name ->
            let
                changeRightSquadName squad =
                    if squad.id == id then
                        { squad | name = name }
                    else
                        squad
            in
                { model
                    | list = List.map changeRightSquadName model.list
                }

        _ ->
            model
