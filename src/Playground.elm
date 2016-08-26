module Playground exposing
    ( init
    , view
    , update
    , subscriptions
    )

import Char exposing (..)
import Html as H
import Html.Attributes as HA
import Html.Events as HE
import List exposing (map)
import Random exposing (..)
import String exposing (slice)
import Svg as S
import Svg.Attributes as SA
import Svg.Events as SE

type alias Model =
    { cells : List Cell
    , hoovered : String
    , edited : Maybe Cell
    }

type alias Cell =
    { editing : Bool
    , name : String
    , posX : Int
    , posY : Int
    }

type Msg
    = MouseOver String
    | MouseOut
    | RandomCell
    | NewCell Cell

init : (Model, Cmd Msg)
init = ({cells = [], hoovered = "-", edited = Nothing}, Cmd.none)

view : Model -> H.Html Msg
view model =
    H.div [backgroundStyle]
        [ H.div [widgetPaneStyle]
            [ S.svg [ SA.viewBox "0 0 1000 1000" ]
                  (List.map viewCell model.cells)
            ]
        , H.div [controlPaneStyle]
            [ H.text model.hoovered
            , H.br [] []
            , H.button
                [ HA.style [("background-color", "green")]
                , HE.onClick RandomCell
                ]
                [ H.text "Random Cell"
                ]
            ]
        ]

viewCell : Cell -> S.Svg Msg
viewCell cell =
    let strX = toString cell.posX
        strY = toString cell.posY
        editingStyle = if cell.editing
                           then [SA.strokeDasharray "5,5"]
                           else []
    in
        S.g [ SE.onMouseOver (MouseOver cell.name)
            , SE.onMouseOut MouseOut
            ]
            [ S.circle
                  ([ SA.cx strX, SA.cy strY, SA.r "80"
                   , SA.stroke "black", SA.strokeWidth "2"
                   , SA.fill "none"
                   ] ++ editingStyle)
                  []
            , S.circle
                [ SA.cx strX, SA.cy strY, SA.r "5"
                , SA.fill "blue"
                ] []
            ]

update : Msg -> Model -> (Model, Cmd Msg)
update msg model = 
    case msg of
        MouseOver str -> ({model | hoovered = str}, Cmd.none)
        MouseOut      -> ({model | hoovered = "-"}, Cmd.none)
        RandomCell    -> (model, Random.generate NewCell randomCell)
        NewCell cell  -> ({model | cells = cell :: model.cells}, Cmd.none)

subscriptions : Model -> Sub Msg
subscriptions model = Sub.none

-- Styles
backgroundStyle : H.Attribute msg
backgroundStyle =
    HA.style
        [ ("height", "100%")
        ]

widgetPaneStyle : H.Attribute msg
widgetPaneStyle =
    HA.style
        [ ("backgroundColor", "light-gray")
        , ("height", "100%")
        , ("width", "80%")
        , ("float", "left")
        ]

controlPaneStyle : H.Attribute msg
controlPaneStyle =
    HA.style
        [ ("backgroundColor", "white")
        , ("height", "100%")
        , ("width", "20%")
        , ("float", "left")
        ]

randomCell : Generator Cell
randomCell = Random.map3 (Cell True) cellName pos pos

cellName : Generator String
cellName =
    Random.map String.fromList (int 3 10 `andThen` (\len -> list len letter))

letter : Generator Char
letter = Random.map (\n -> Char.fromCode (n + 97)) (int 0 25)

pos : Generator Int
pos = int 80 920
