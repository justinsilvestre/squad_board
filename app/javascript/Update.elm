module Update exposing (..)

import Dict
import Model exposing (..)
import Message exposing (..)


receiveTeamMembers : List TeamMember -> Dict.Dict TeamMemberId TeamMember
receiveTeamMembers teamMemberList =
    List.foldr (\tm d -> Dict.insert tm.id tm d) Dict.empty teamMemberList


update : Message -> Model -> ( Model, Cmd Message )
update message model =
    case message of
        SetText text ->
            ( { model | text = text }, Cmd.none )

        FetchTeamMembers ->
            ( model, fetchTeamMembers )

        ReceiveTeamMembers (Ok resp) ->
            ( { model | teamMembers = receiveTeamMembers resp }, Cmd.none )

        AddTeamMemberToTray id ->
            ( { model | teamMembersTray = model.teamMembersTray ++ [ id ], trayMenuIsOpen = False }, Cmd.none )

        RemoveTeamMemberFromTray tmid ->
            ( { model | teamMembersTray = List.filter (\i -> i /= tmid) model.teamMembersTray }, Cmd.none )

        OpenTrayMenu ->
            ( { model | trayMenuIsOpen = True }, Cmd.none )

        CloseTrayMenu ->
            ( { model | trayMenuIsOpen = False }, Cmd.none )

        AddSquad ->
            ( { model
                | squads = model.squads ++ [ Squad (NewSquadId model.nextSquadId) [] "boop" ]
                , nextSquadId = model.nextSquadId + 1
              }
            , Cmd.none
            )

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
                ( { model
                    | squads = List.map changeSquadMembers model.squads
                    , teamMembersTray = List.filter ((/=) teamMemberId) model.teamMembersTray
                  }
                , Cmd.none
                )

        DragOverSquad squadId ->
            ( { model | dragEnterSquadId = Just squadId }, Cmd.none )

        DragTeamMember maybeId ->
            ( { model | draggedTeamMemberId = maybeId }, Cmd.none )

        -- MoveMouse mousePosition ->
        --     ( { model | mousePosition = mousePosition }, Cmd.none )
        _ ->
            ( model, Cmd.none )
