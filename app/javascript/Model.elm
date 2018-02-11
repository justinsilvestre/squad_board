module Model exposing (..)

import Dict
import Mouse
import DatePicker
import Date exposing (Date)


type SquadId
    = Int
    | NewSquadId Int


type alias Squad =
    { id : SquadId
    , teamMembers : List TeamMemberId
    , name : String
    }


type alias SquadsList =
    { list : List Squad, nextSquadId : SquadId }


type alias TeamMemberId =
    Int


type alias TeamMember =
    { id : TeamMemberId
    , name : String
    , avatar : String
    }


type alias TeamMembersTray =
    { isOpen : Bool
    , teamMemberIds : List TeamMemberId
    }


type alias MouseState =
    { position : Mouse.Position
    , dragEnterSquadId : Maybe SquadId
    , draggedTeamMemberId : Maybe TeamMemberId
    }


type SeasonDate
    = SeasonStart
    | SeasonEnd


type alias SeasonDates =
    { start : Maybe Date
    , end : Maybe Date
    , startDatePicker : DatePicker.DatePicker
    , endDatePicker : DatePicker.DatePicker
    }


type alias Model =
    { teamMembers : Dict.Dict TeamMemberId TeamMember
    , squadsList : SquadsList
    , teamMembersTray : TeamMembersTray
    , mouse : MouseState
    , seasonDates : SeasonDates
    }


initialState : DatePicker.DatePicker -> DatePicker.DatePicker -> Model
initialState startDatePicker endDatePicker =
    Model
        Dict.empty
        (SquadsList [] (NewSquadId 0))
        (TeamMembersTray False [])
        (MouseState { x = 0, y = 0 } Nothing Nothing)
        (SeasonDates Nothing Nothing startDatePicker endDatePicker)
