module ViewSquadsSection exposing (..)

import Html exposing (Html, section, text, input)
import Html.Attributes exposing (class, value)
import Html.Events exposing (onInput)
import Model exposing (Model, Squad)
import Message exposing (Message(AddTeamMemberToSquad, RemoveTeamMemberFromTray, None, DragOverSquad, SetSquadName))
import Selectors exposing (getTeamMember)
import ViewTeamMembersUl exposing (teamMembersUl)
import Utils.Events exposing (onDragOver, onDrop)


($) : (a -> b) -> a -> b
($) f g =
    f g


squadSection : Model -> Squad -> Html Message
squadSection model squad =
    let
        dropAction =
            case model.mouse.draggedTeamMemberId of
                Just teamMemberId ->
                    (AddTeamMemberToSquad squad.id teamMemberId)

                Nothing ->
                    None

        teamMembersList =
            List.filterMap (getTeamMember model) squad.teamMembers

        teamMembersMessages =
            { onDelete = RemoveTeamMemberFromTray, onMemberDrop = (\_ _ -> None) }
    in
        section
            [ class "squad"
            , onDragOver $ DragOverSquad squad.id
            , onDrop dropAction
            ]
            [ text $ toString squad.teamMembers
            , input [ onInput $ SetSquadName squad.id, value squad.name ] []
            , teamMembersUl teamMembersMessages teamMembersList
            ]


squadsSection : List Squad -> Model -> Html Message
squadsSection squads model =
    section [ class "squads" ] (List.map (squadSection model) squads)
