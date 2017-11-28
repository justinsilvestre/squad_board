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


type alias TeamMemberId =
    Int


type alias TeamMember =
    { id : TeamMemberId
    , name : String
    , avatar : String
    }


type alias Model =
    { text : String
    , teamMembers : Dict.Dict TeamMemberId TeamMember
    , mousePosition : Mouse.Position
    , squads : List Squad
    , teamMembersTray : List Int
    , trayMenuIsOpen : Bool
    , nextSquadId : Int
    , dragEnterSquadId : Maybe SquadId
    , draggedTeamMemberId : Maybe TeamMemberId
    }


initialState : Model
initialState =
    Model "hii" Dict.empty (Mouse.Position 200 200) [] [] False 0 Nothing Nothing


teamMembersInTray : Model -> List TeamMember
teamMembersInTray model =
    let
        getTeamMember id =
            Dict.get id model.teamMembers
    in
        List.filterMap getTeamMember model.teamMembersTray


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
getAssignedTeamMemberIds { teamMembers, squads } =
    let
        blah =
            Debug.log "blah" (List.concat (List.map .teamMembers squads))
    in
        List.concat (List.map .teamMembers squads)


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
