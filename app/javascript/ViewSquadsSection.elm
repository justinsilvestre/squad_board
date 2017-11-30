module ViewSquadsSection exposing (..)

import Html exposing (Html, h1, text, p, section, ul, li, div, img, span, select, option, button)
import Html.Attributes exposing (style, src, class, value, disabled, draggable, selected)
import Html.Events exposing (onInput, onClick)
import Json.Decode
import Model exposing (..)
import Message exposing (..)
import Selectors exposing (..)
import ViewTeamMembersUl exposing (..)
import Utils.Events exposing (..)


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
            , onDragOver (DragOverSquad squad.id)
            , onDrop dropAction
            ]
            [ text (toString squad.teamMembers), teamMembersUl teamMembersMessages teamMembersList ]


squadsSection : List Squad -> Model -> Html Message
squadsSection squads model =
    section [ class "squads" ] (List.map (squadSection model) squads)
