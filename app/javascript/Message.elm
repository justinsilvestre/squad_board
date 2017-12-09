module Message exposing (..)

import Http
import Json.Decode exposing (Decoder, list, string, int, map3, field)
import Model exposing (..)
import Mouse


-- MESSAGE


fetchTeamMembers : Cmd Message
fetchTeamMembers =
    let
        url =
            "http://localhost:3000/team_members.json"

        request =
            Http.get url decoder
    in
        Http.send ReceiveTeamMembers request


decoder : Decoder (List TeamMember)
decoder =
    list
        (map3 TeamMember
            (field "id" int)
            (field "name" string)
            (field "avatar" string)
        )


type Message
    = None
    | FetchTeamMembers
    | ReceiveTeamMembers (Result Http.Error (List TeamMember))
    | AddTeamMemberToTray (Maybe TeamMemberId)
    | RemoveTeamMemberFromTray TeamMemberId
    | OpenTrayMenu
    | CloseTrayMenu
    | AddSquad
    | AddTeamMemberToSquad SquadId TeamMemberId
    | RemoveTeamMemberFromSquad SquadId TeamMemberId
    | DragOverSquad SquadId
    | DragTeamMember (Maybe TeamMemberId)
    | SetText String
    | MoveMouse Mouse.Position
    | DragStart String
    | SetSquadName SquadId String
