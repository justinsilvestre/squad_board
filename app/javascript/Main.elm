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


init : ( Model, Cmd Message )
init =
    let
        ( datePicker, datePickerCmd ) =
            DatePicker.init
    in
        initialState datePicker datePicker
            ! [ fetchTeamMembers
              , Cmd.map (SetDatePicker SeasonStart) datePickerCmd
              , Cmd.map (SetDatePicker SeasonEnd) datePickerCmd
              , Date.now
                    |> andThen (\now -> succeed (Just now))
                    |> Task.perform (SetSeasonDate SeasonStart)
              , Date.now
                    |> andThen (\now -> succeed (Just now))
                    |> Task.perform (SetSeasonDate SeasonEnd)
              ]



-- MAIN


main : Program Never Model Message
main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
