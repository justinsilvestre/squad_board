module Selectors exposing (..)

import Dict
import Model exposing (..)


isTrayMenuOpen : Model -> Bool
isTrayMenuOpen { teamMembersTray } =
    teamMembersTray.isOpen


teamMembersInTray : Model -> List TeamMember
teamMembersInTray model =
    let
        getTeamMember id =
            Dict.get id model.teamMembers
    in
        List.filterMap getTeamMember model.teamMembersTray.teamMemberIds


getTeamMember : Model -> TeamMemberId -> Maybe TeamMember
getTeamMember model id =
    Dict.get id model.teamMembers


getTeamMembersList : Model -> List TeamMember
getTeamMembersList { teamMembers } =
    teamMembers
        |> Dict.toList
        |> List.map Tuple.second


isInSquad : Squad -> TeamMemberId -> Bool
isInSquad squad teamMemberId =
    List.member teamMemberId squad.teamMembers


getTeamMemberIds : Model -> List TeamMemberId
getTeamMemberIds { teamMembers } =
    List.map Tuple.first (Dict.toList teamMembers)


getAssignedTeamMemberIds : Model -> List TeamMemberId
getAssignedTeamMemberIds { teamMembers, squadsList } =
    List.concat (List.map .teamMembers squadsList.list)


getOffScreenTeamMembers : Model -> List TeamMember
getOffScreenTeamMembers model =
    let
        teamMemberIds =
            getTeamMemberIds model

        onScreenTeamMemberIds =
            (getAssignedTeamMemberIds model) ++ (List.map .id (teamMembersInTray model))
    in
        teamMemberIds
            |> List.filter (\id -> not (List.member id onScreenTeamMemberIds))
            |> List.filterMap (\id -> getTeamMember model id)
