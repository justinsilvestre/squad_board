module Utils.SquadHelpers exposing (..)

import Model exposing (..)


squadIdToString : SquadId -> String
squadIdToString squadId =
    case squadId of
        NewSquadId int ->
            "N" ++ toString int

        int ->
            toString int


squadNameInputId : SquadId -> String
squadNameInputId squadId =
    "squadNameInput" ++ (squadIdToString squadId)
