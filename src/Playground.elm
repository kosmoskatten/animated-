module Playground exposing
    ( init
    , view
    , update
    , subscriptions
    )

import Html as H
import Html.Attributes as HA
import Svg as S
import Svg.Attributes as SA

type alias Model = String

type Msg = Nop

init : (Model, Cmd Msg)
init = ("foo", Cmd.none)

view : Model -> H.Html Msg
view model =
    H.div [backgroundStyle]
        [ H.div [widgetPaneStyle]
            [ S.svg [ SA.viewBox "0 0 300 300" ]
                  [ S.circle [ SA.cx "100", SA.cy "100", SA.r "80" ]
                        [
                        ]
                  ]
            ]
        , H.div [controlPaneStyle]
            [ H.text model
            ]
        ]

update : Msg -> Model -> (Model, Cmd Msg)
update msg model = (model, Cmd.none)

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
        [ ("backgroundColor", "yellow")
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
