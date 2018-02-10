module Update exposing (..)

import Task
import Dom exposing (focus)
import Model exposing (..)
import Message exposing (..)
import UpdateTeamMembersTray exposing (updateTeamMembersTray)
import UpdateTeamMembers exposing (updateTeamMembers)
import UpdateSquadsList exposing (updateSquadsList)
import UpdateMouse exposing (updateMouse)
import UpdateSeasonDates exposing (updateSeasonDates)
import Utils.SquadHelpers exposing (squadNameInputId)
import Date


update : Message -> Model -> ( Model, Cmd Message )
update message model =
    ( commandFreeUpdate message model, getCommand message model )


commandFreeUpdate : Message -> Model -> Model
commandFreeUpdate message model =
    { model
        | squadsList = updateSquadsList message model.squadsList
        , teamMembersTray = updateTeamMembersTray message model.teamMembersTray
        , teamMembers = updateTeamMembers message model.teamMembers
        , mouse = updateMouse message model.mouse
        , seasonDates = updateSeasonDates message model.seasonDates
    }


getCommand : Message -> Model -> Cmd Message
getCommand message model =
    case message of
        FetchTeamMembers ->
            fetchTeamMembers

        AddSquad ->
            squadNameInputId model.squadsList.nextSquadId
                |> Dom.focus
                |> Task.attempt FocusResult

        _ ->
            Cmd.none
