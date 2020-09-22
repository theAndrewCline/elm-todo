module Main exposing (main)

import Browser
import Html exposing (button, div, h1, p, text)
import Html.Attributes exposing (class)
import Html.Events exposing (onClick)


type alias Model =
    Int


type Msg
    = Increament
    | Decreament


update : Msg -> Model -> Model
update msg model =
    case msg of
        Increament ->
            model + 1

        Decreament ->
            model - 1


view model =
    div [ class "bg-gray-200 min-h-screen pt-8" ]
        [ div [ class "container mx-auto" ]
            [ div [ class "bg-white shadow-lg rounded w-1/3 mx-auto flex flex-col items-center justify-center" ]
                [ p [ class "text-4xl" ]
                    [ text <| String.fromInt model ]
                , div
                    []
                    [ button [ class "bg-blue-500 px-8 py-2 m-2 rounded", onClick Increament ] [ text "+" ]
                    , button [ class "bg-blue-500 px-8 py-2 m-2 rounded", onClick Decreament ] [ text "-" ]
                    ]
                ]
            ]
        ]


main =
    Browser.sandbox { init = 0, view = view, update = update }
