module UpdateSeasonDates exposing (..)

import Message exposing (..)
import Model exposing (..)


updateSeasonDates : Message -> SeasonDates -> SeasonDates
updateSeasonDates message model =
    case message of
        SetSeasonStart date ->
            { model | start = date }

        SetSeasonEnd date ->
            { model | end = date }

        ShowSeasonDatePicker ->
            { model | editing = True }

        HideSeasonDatePicker ->
            { model | editing = False }

        _ ->
            model
