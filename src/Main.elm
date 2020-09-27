module Main exposing (main)

import Browser
import Html exposing (Html, button, div, input, p, text)
import Html.Attributes exposing (checked, class, placeholder, type_, value)
import Html.Events exposing (onClick, onInput)



-- PROGRAM


main : Program () Model Msg
main =
    Browser.sandbox
        { init =
            { list =
                [ { title = "Code More Elm!"
                  , completed = False
                  , id = 1
                  }
                , { title = "Make More Things"
                  , completed = False
                  , id = 2
                  }
                ]
            , input = ""
            }
        , view = view
        , update = update
        }



-- MODEL


type alias Todo =
    { title : String
    , completed : Bool
    , id : Int
    }


type alias Model =
    { list : List Todo
    , input : String
    }



-- UPDATE


type Msg
    = AddTodo
    | ToggleCompleted Int
    | DeleteTodo Int
    | UpdateInput String


update : Msg -> Model -> Model
update msg model =
    case msg of
        AddTodo ->
            { input = ""
            , list =
                model.list
                    ++ [ { title = model.input
                         , completed = False
                         , id = 1
                         }
                       ]
            }

        UpdateInput string ->
            { model | input = string }

        ToggleCompleted id ->
            { model
                | list =
                    List.map
                        (\x ->
                            if x.id == id then
                                { x | completed = not x.completed }

                            else
                                x
                        )
                        model.list
            }

        _ ->
            model



-- VIEW


view : Model -> Html Msg
view model =
    div [ class "bg-gray-200 min-h-screen pt-8" ]
        [ div
            [ class "container mx-auto" ]
            [ div
                [ class "bg-white shadow-lg rounded w-2/3 mx-auto flex flex-col items-left justify-center" ]
                [ listView model.list
                , inputView model.input
                ]
            ]
        ]


inputView : String -> Html Msg
inputView v =
    div [ class "m-auto" ]
        [ input [ class "border px-4 py-2 m-2 text-xl", onInput UpdateInput, value v, placeholder "Add a todo!" ] []
        , button [ class "bg-blue-400 px-8 py-2 m-2 rounded text-xl text-black", onClick AddTodo ] [ text "+" ]
        ]


listView : List Todo -> Html Msg
listView list =
    div [] <| List.map todoView list


todoView : Todo -> Html Msg
todoView todo =
    let
        classes =
            if todo.completed then
                "ml-2 text-xl line-through text-gray-500"

            else
                "ml-2 text-xl"
    in
    div [ class "flex items-center mx-4", onClick (ToggleCompleted todo.id) ]
        [ input [ type_ "checkbox", checked todo.completed ] []
        , p [ class classes ] [ text todo.title ]
        ]
