module Model exposing (..)

import Dict
import Mouse


type SquadId
    = Int
    | NewSquadId Int


type alias Squad =
    { id : SquadId
    , teamMembers : List TeamMemberId
    , name : String
    }


type alias SquadsList =
    { list : List Squad, nextSquadId : SquadId }


type alias TeamMemberId =
    Int


type alias TeamMember =
    { id : TeamMemberId
    , name : String
    , avatar : String
    }


type alias TeamMembersTray =
    { isOpen : Bool
    , teamMemberIds : List TeamMemberId
    }


type alias MouseState =
    { position : Mouse.Position
    , dragEnterSquadId : Maybe SquadId
    , draggedTeamMemberId : Maybe TeamMemberId
    }


type alias Model =
    { teamMembers : Dict.Dict TeamMemberId TeamMember
    , squadsList : SquadsList
    , teamMembersTray : TeamMembersTray
    , mouse : MouseState
    }


initialState : Model
initialState =
    Model
        Dict.empty
        (SquadsList [] (NewSquadId 0))
        (TeamMembersTray False [])
        (MouseState { x = 0, y = 0 } Nothing Nothing)


teamMembersInTray : Model -> List TeamMember
teamMembersInTray model =
    let
        getTeamMember id =
            Dict.get id model.teamMembers
    in
        List.filterMap getTeamMember model.teamMembersTray.teamMemberIds


isTrayMenuOpen : Model -> Bool
isTrayMenuOpen model =
    model.teamMembersTray.isOpen


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
    let
        blah =
            Debug.log "blah" (List.concat (List.map .teamMembers squadsList.list))
    in
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
