module Playground exposing
    ( init
    , view
    , update
    , subscriptions
    )

import Html exposing (..)

type alias Model = String

type Msg = Nop

init : (Model, Cmd Msg)
init = ("foo", Cmd.none)

view : Model -> Html Msg
view model =
    div []
        [ text model
        ]

update : Msg -> Model -> (Model, Cmd Msg)
update msg model = (model, Cmd.none)

subscriptions : Model -> Sub Msg
subscriptions model = Sub.none
