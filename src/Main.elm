module Main exposing (main)

import Browser
import Html exposing (button, div, h1, p, text)
import Html.Attributes exposing (class)
import Html.Events exposing (onClick)


type alias Todo =
    { title : String
    , completed : Bool
    , id : Int

    -- , tags : List String
    }


type alias Model =
    List Todo


type Msg
    = AddTodo String
    | CompleteTodo Int
    | DeleteTodo Int


update : Msg -> Model -> Model
update msg model =
    case msg of
        AddTodo title ->
            model ++ [ { title = title, completed = False, id = 1 } ]

        _ ->
            model


view model =
    div [ class "bg-gray-200 min-h-screen pt-8" ]
        [ div [ class "container mx-auto" ]
            [ div [ class "bg-white shadow-lg rounded w-1/3 mx-auto flex flex-col items-center justify-center" ]
                [ div
                    []
                  <|
                    List.map
                        (\todo -> p [ class "text-4xl" ] [ text todo.title ])
                        model
                , div []
                    [ button [ class "bg-blue-500 px-8 py-2 m-2 rounded", onClick <| AddTodo "Code More Elm" ] [ text "+" ]
                    ]
                ]
            ]
        ]


main =
    Browser.sandbox { init = [], view = view, update = update }
