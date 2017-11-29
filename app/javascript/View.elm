module View exposing (..)

import Html exposing (Html, h1, text, p, section, ul, li, div, img, span, select, option, button)
import Html.Attributes exposing (style, src, class, value, disabled, draggable, selected)
import Html.Events exposing (onInput, onClick)
import Json.Decode
import Model exposing (..)
import Message exposing (..)


px a =
    (toString a) ++ "px"


(=>) : a -> b -> ( a, b )
(=>) =
    (,)


onDragStart : Message -> Html.Attribute Message
onDragStart message =
    Html.Events.on "dragstart" (Json.Decode.succeed message)


onDragEnd : Message -> Html.Attribute Message
onDragEnd message =
    Html.Events.on "dragend" (Json.Decode.succeed message)


onDragOver : Message -> Html.Attribute Message
onDragOver message =
    Html.Events.onWithOptions "dragover" { preventDefault = True, stopPropagation = False } (Json.Decode.succeed message)


onDrop : Message -> Html.Attribute Message
onDrop message =
    Html.Events.on "drop" (Json.Decode.succeed message)


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


trayMenuItem : TeamMember -> Html Message
trayMenuItem teamMember =
    li [ onClick (AddTeamMemberToTray teamMember.id) ] [ text teamMember.name ]


buttonOrTrayMenu : Model -> Html Message
buttonOrTrayMenu model =
    let
        offScreenTeamMembers =
            getOffScreenTeamMembers model
    in
        if isTrayMenuOpen model then
            ul [] (List.map trayMenuItem offScreenTeamMembers)
        else
            button [ onClick OpenTrayMenu ] []


view : Model -> Html Message
view model =
    let
        teamMembersList =
            getTeamMembersList model

        squads =
            model.squadsList.list

        teamMemberOption { name, id } =
            option [ value (toString id) ] [ text name ]

        addToSquadMessage : TeamMemberId -> Message
        addToSquadMessage =
            case model.mouse.dragEnterSquadId of
                Just id ->
                    AddTeamMemberToSquad id

                Nothing ->
                    (\_ -> None)

        trayMessages =
            { onDelete = RemoveTeamMemberFromTray, onMemberDrop = (\_ -> None) }
    in
        section []
            [ button [ class "add-squad-button", onClick AddSquad ] []
            , squadsSection squads model
            , section [ class "team-members-tray" ]
                [ buttonOrTrayMenu model
                , teamMembersUl { onDelete = RemoveTeamMemberFromTray, onMemberDrop = \squadId teamMemberId -> None } (teamMembersInTray model)
                ]
            ]


position { x, y } =
    [ "position" => "absolute"
    , "left" => px x
    , "top" => px y
    ]
