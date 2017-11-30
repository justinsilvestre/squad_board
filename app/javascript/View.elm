module View exposing (..)

import Html exposing (Html, h1, text, p, section, ul, li, div, img, span, select, option, button)
import Html.Attributes exposing (style, src, class, value, disabled, draggable, selected)
import Html.Events exposing (onInput, onClick)
import Json.Decode
import Model exposing (..)
import Message exposing (..)
import Selectors exposing (..)
import ViewSquadsSection exposing (squadsSection)
import ViewTeamMembersUl exposing (teamMembersUl)


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
