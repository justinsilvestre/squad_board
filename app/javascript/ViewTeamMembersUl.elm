module ViewTeamMembersUl exposing (..)

import Html exposing (Html, li, img, span, text, button, ul)
import Html.Attributes exposing (class, draggable, src)
import Html.Events exposing (onClick)
import Model exposing (..)
import Message exposing (..)
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
    }


teamMembersUl : TeamMembersUlMessages -> List TeamMember -> Html Message
teamMembersUl messages teamMembersList =
    let
        liMessages =
            { onDelete = messages.onDelete }
    in
        ul [ class "team-members" ] (List.map (teamMemberLi liMessages) teamMembersList)
