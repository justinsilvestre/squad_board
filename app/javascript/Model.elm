module Model exposing (..)

import Dict
import Mouse


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


type alias Model =
    { teamMembers : Dict.Dict TeamMemberId TeamMember
    , squadsList : SquadsList
    , teamMembersTray : TeamMembersTray
    , mouse : MouseState
    }


initialState : Model
initialState =
    Model
        Dict.empty
        (SquadsList [] (NewSquadId 0))
        (TeamMembersTray False [])
        (MouseState { x = 0, y = 0 } Nothing Nothing)
