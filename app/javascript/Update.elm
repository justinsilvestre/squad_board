module Update exposing (..)

import Model exposing (..)
import Message exposing (..)
import UpdateTeamMembersTray exposing (updateTeamMembersTray)
import UpdateTeamMembers exposing (updateTeamMembers)
import UpdateSquadsList exposing (updateSquadsList)
import UpdateMouse exposing (updateMouse)


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


commandFreeUpdate : Message -> Model -> Model
commandFreeUpdate message model =
    { model
        | squadsList = updateSquadsList message model.squadsList
        , teamMembersTray = updateTeamMembersTray message model.teamMembersTray
        , teamMembers = updateTeamMembers message model.teamMembers
        , mouse = updateMouse message model.mouse
    }
