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
import DatePicker


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

        SetDatePicker seasonDateKey msg ->
            let
                datePicker =
                    case seasonDateKey of
                        SeasonStart ->
                            model.seasonDates.startDatePicker

                        SeasonEnd ->
                            model.seasonDates.endDatePicker

                ( newDatePicker, datePickerCmd, dateEvent ) =
                    DatePicker.update DatePicker.defaultSettings msg datePicker
            in
                Cmd.map (SetDatePicker seasonDateKey) datePickerCmd

        _ ->
            Cmd.none
