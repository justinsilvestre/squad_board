module UpdateTeamMembers exposing (..)

import Dict
import Message exposing (..)
import Model exposing (..)


receiveTeamMembers : List TeamMember -> Dict.Dict TeamMemberId TeamMember
receiveTeamMembers teamMemberList =
    List.foldr (\tm d -> Dict.insert tm.id tm d) Dict.empty teamMemberList


updateTeamMembers : Message -> Dict.Dict TeamMemberId TeamMember -> Dict.Dict TeamMemberId TeamMember
updateTeamMembers message model =
    case message of
        ReceiveTeamMembers (Ok teamMembersResponse) ->
            let
                buildDict tm d =
                    Dict.insert tm.id tm d
            in
                List.foldr buildDict Dict.empty teamMembersResponse

        _ ->
            model
