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
        initialState datePicker
            ! [ fetchTeamMembers
              , Cmd.map SetDatePicker datePickerCmd
              , Date.now
                    |> andThen (\now -> succeed (Just now))
                    |> Task.perform SetSeasonStart
              , Date.now
                    |> andThen (\now -> succeed (Just now))
                    |> Task.perform SetSeasonEnd
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
