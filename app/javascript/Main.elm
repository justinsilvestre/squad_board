module Main exposing (..)

import Html
import Model exposing (..)
import Message exposing (..)
import View exposing (..)
import Update exposing (..)
import Subscriptions exposing (..)


init : ( Model, Cmd Message )
init =
    ( initialState, fetchTeamMembers )



-- MAIN


main : Program Never Model Message
main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
