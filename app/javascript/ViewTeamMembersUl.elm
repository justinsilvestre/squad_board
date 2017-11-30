module ViewTeamMembersUl exposing (..)

import Html exposing (Html, h1, text, p, section, ul, li, div, img, span, select, option, button)
import Html.Attributes exposing (style, src, class, value, disabled, draggable, selected)
import Html.Events exposing (onInput, onClick)
import Json.Decode
import Model exposing (..)
import Message exposing (..)
import Selectors exposing (..)
import Utils.Events exposing (..)


type alias TeamMembersLiMessages =
    { onDelete : TeamMemberId -> Message }


teamMemberLi : TeamMembersLiMessages -> TeamMember -> Html Message
teamMemberLi { onDelete } { name, avatar, id } =
    li
        [ Html.Attributes.id (toString id)
        , class "team-member"
        , draggable "true"
        , onDragStart (DragTeamMember (Just id))
        , onDragEnd (DragTeamMember Nothing)
        ]
        [ img [ src avatar ] []
        , span [ class "team-member-name" ] [ text name ]
        , button [ class "team-member-delete", onClick (onDelete id) ] [ text "x" ]
        ]


type alias TeamMembersUlMessages =
    { onDelete : TeamMemberId -> Message
    , onMemberDrop : SquadId -> TeamMemberId -> Message
    }


teamMembersUl : TeamMembersUlMessages -> List TeamMember -> Html Message
teamMembersUl messages teamMembersList =
    let
        liMessages =
            { onDelete = messages.onDelete }
    in
        ul [ class "team-members" ] (List.map (teamMemberLi liMessages) teamMembersList)
