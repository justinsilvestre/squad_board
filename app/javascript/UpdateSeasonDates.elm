module UpdateSeasonDates exposing (..)

import Message exposing (..)
import Model exposing (..)
import DatePicker


updateSeasonDates : Message -> SeasonDates -> SeasonDates
updateSeasonDates message model =
    case message of
        SetSeasonDate dateKey date ->
            case dateKey of
                SeasonStart ->
                    { model | start = date }

                SeasonEnd ->
                    { model | end = date }

        SetDatePicker dateKey msg ->
            let
                datePicker =
                    case dateKey of
                        SeasonStart ->
                            model.startDatePicker

                        SeasonEnd ->
                            model.endDatePicker

                ( newDatePicker, datePickerCmd, dateEvent ) =
                    DatePicker.update DatePicker.defaultSettings msg datePicker
            in
                case dateEvent of
                    DatePicker.NoChange ->
                        case dateKey of
                            SeasonStart ->
                                { model | startDatePicker = newDatePicker }

                            SeasonEnd ->
                                { model | endDatePicker = newDatePicker }

                    DatePicker.Changed newDate ->
                        case dateKey of
                            SeasonStart ->
                                { model | start = newDate, startDatePicker = newDatePicker }

                            SeasonEnd ->
                                { model | end = newDate, endDatePicker = newDatePicker }

        _ ->
            model
