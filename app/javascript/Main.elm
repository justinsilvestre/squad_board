port module Main exposing (..)

import Html exposing (Html, h1, text, p, section)
import Html.Attributes exposing (style)
import Html.Events exposing (onClick)

-- MODEL

type alias Model =
  { text: String
  }

-- INIT

type alias Flags =
  { text: String
  }

init : Flags -> (Model, Cmd Message)
init flags =
  (Model flags.text, Cmd.none)

-- VIEW

view : Model -> Html Message
view model =
  -- The inline style is being used for example purposes in order to keep this example simple and
  -- avoid loading additional resources. Use a proper stylesheet when building your own app.
  section [ ] [
    h1 [
      style [("display", "flex"), ("justify-content", "center")],
      onClick (SetText "boop")
      ]
       [text "Hello Elm!"],
    p [ ] [text model.text]
    ]

-- MESSAGE

type Message =
  None
  | SetText String

-- UPDATE

update : Message -> Model -> (Model, Cmd Message)
update message model =
  case message of
    SetText text -> ({ text = text }, Cmd.none)
    _ -> (model, Cmd.none)

-- SUBSCRIPTIONS

port newText : (String -> msg) -> Sub msg

subscriptions : Model -> Sub Message
subscriptions model =
  newText SetText

-- MAIN

main : Program Flags Model Message
main =
  Html.programWithFlags
    {
      init = init,
      view = view,
      update = update,
      subscriptions = subscriptions
    }
