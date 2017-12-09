module View exposing (..)

import Html exposing (Html, h1, text, p, section, ul, li, div, img, span, select, option, button)
import Html.Attributes exposing (style, src, class, value, disabled, draggable, selected)
import Html.Events exposing (onInput, onClick)
import Utils.Events exposing (onDrop, onDragOver)
import Model exposing (..)
import Message exposing (..)
import Selectors exposing (..)
import ViewSquadsSection exposing (squadsSection)
import ViewTeamMembersUl exposing (teamMembersUl)


($) : (a -> b) -> a -> b
($) a b =
    a b


trayMenuItem : TeamMember -> Html Message
trayMenuItem teamMember =
    li [ onClick $ AddTeamMemberToTray (Just teamMember.id) ] [ text teamMember.name ]


teamMembersTray : Model -> Html Message
teamMembersTray model =
    let
        messages =
            { onDelete = RemoveTeamMemberFromTray }
    in
        section
            [ class "team-members-tray"
            , draggable "true"
            , onDrop $ AddTeamMemberToTray model.mouse.draggedTeamMemberId
            , onDragOver None
            ]
            [ buttonOrTrayMenu model
            , teamMembersUl messages (teamMembersInTray model)
            ]


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
        squads =
            model.squadsList.list
    in
        section []
            [ button [ class "add-squad-button", onClick AddSquad ] []
            , squadsSection squads model
            , teamMembersTray model
            ]
