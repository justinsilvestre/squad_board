module Update exposing (..)

import Dict
import Model exposing (..)
import Message exposing (..)


receiveTeamMembers : List TeamMember -> Dict.Dict TeamMemberId TeamMember
receiveTeamMembers teamMemberList =
    List.foldr (\tm d -> Dict.insert tm.id tm d) Dict.empty teamMemberList


update : Message -> Model -> ( Model, Cmd Message )
update message model =
    let
        command =
            case message of
                FetchTeamMembers ->
                    fetchTeamMembers

                _ ->
                    Cmd.none
    in
        ( commandFreeUpdate message model, command )


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

        _ ->
            model


updateTeamMembers : Message -> Dict.Dict TeamMemberId TeamMember -> Dict.Dict TeamMemberId TeamMember
updateTeamMembers message model =
    case message of
        ReceiveTeamMembers (Ok resp) ->
            receiveTeamMembers resp

        _ ->
            model


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


updateMouse : Message -> MouseState -> MouseState
updateMouse message model =
    case message of
        DragOverSquad squadId ->
            { model | dragEnterSquadId = Just squadId }

        DragTeamMember maybeId ->
            { model | draggedTeamMemberId = maybeId }

        _ ->
            model


commandFreeUpdate : Message -> Model -> Model
commandFreeUpdate message model =
    { model
        | squadsList = updateSquadsList message model.squadsList
        , teamMembersTray = updateTeamMembersTray message model.teamMembersTray
        , teamMembers = updateTeamMembers message model.teamMembers
        , mouse = updateMouse message model.mouse
    }
