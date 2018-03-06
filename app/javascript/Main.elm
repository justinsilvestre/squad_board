module Main exposing (..)

import Html
import Model exposing (..)
import Message exposing (..)
import View exposing (..)
import Update exposing (..)
import Subscriptions exposing (..)
import DatePicker
import Date exposing (..)
import Task exposing (..)


init : Flags -> ( Model, Cmd Message )
init { season, tray } =
    let
        ( datePicker, datePickerCmd ) =
            DatePicker.init

        parseDate maybeString =
            case maybeString of
                Just string ->
                    case Date.fromString string of
                        Ok date ->
                            succeed date

                        Err error ->
                            Date.now

                Nothing ->
                    Date.now

        { startDate, endDate } =
            case season of
                Nothing ->
                    { startDate = Date.now, endDate = Date.now }

                Just { start, end } ->
                    { startDate = parseDate start, endDate = parseDate end }
    in
        initialState datePicker datePicker tray
            ! [ fetchTeamMembers
              , Cmd.map (SetDatePicker SeasonStart) datePickerCmd
              , Cmd.map (SetDatePicker SeasonEnd) datePickerCmd
              , startDate
                    |> andThen (\now -> succeed (Just now))
                    |> Task.perform (SetSeasonDate SeasonStart)
              , endDate
                    |> andThen (\now -> succeed (Just now))
                    |> Task.perform (SetSeasonDate SeasonEnd)
              ]



-- MAIN
--
-- type alias TeamMemberObject =
--     { name : String
--     , id : Int
--     , avatar : String
--     }


type alias SquadObject =
    { name : String
    , team_members : List TeamMember
    }


type alias SeasonObject =
    { start : Maybe String
    , end : Maybe String
    , squads : List SquadObject
    }


type alias Flags =
    { season : Maybe SeasonObject
    , tray : List TeamMember
    }


main : Program Flags Model Message
main =
    Html.programWithFlags
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
