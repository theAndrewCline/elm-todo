module Main exposing (main)

import Browser
import Html exposing (Html, button, div, input, p, span, text)
import Html.Attributes exposing (checked, class, placeholder, type_, value)
import Html.Events exposing (onClick, onInput)
import Random
import UUID exposing (UUID)



-- PROGRAM


main : Program () Model Msg
main =
    Browser.element
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


init : () -> ( Model, Cmd Msg )
init _ =
    ( { list = [], input = "" }, Cmd.none )



-- MODEL


type alias Todo =
    { title : String
    , completed : Bool
    , id : UUID
    }


type alias Model =
    { list : List Todo
    , input : String
    }



-- UPDATE


idGenerator : Random.Generator UUID
idGenerator =
    UUID.generator


type Msg
    = AddTodo
    | ToggleCompleted UUID
    | ClearCompleted
    | DeleteTodo UUID
    | UpdateInput String
    | CreateTodo UUID


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        AddTodo ->
            ( model, Random.generate CreateTodo idGenerator )

        CreateTodo id ->
            ( { input = ""
              , list =
                    model.list
                        ++ [ { title = model.input
                             , completed = False
                             , id = id
                             }
                           ]
              }
            , Cmd.none
            )

        UpdateInput string ->
            ( { model | input = string }, Cmd.none )

        ClearCompleted ->
            ( { model | list = List.filter (\x -> not x.completed) model.list }, Cmd.none )

        DeleteTodo id ->
            ( { model | list = List.filter (\x -> x.id /= id) model.list }, Cmd.none )

        ToggleCompleted id ->
            ( { model
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
            , Cmd.none
            )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none



-- VIEW


view : Model -> Html Msg
view model =
    div [ class "bg-gray-200 min-h-screen pt-8" ]
        [ div
            [ class "container mx-auto" ]
            [ div
                [ class "bg-white shadow-lg rounded w-2/3 mx-auto flex flex-col items-left justify-center" ]
                [ listView model.list
                , inputView model
                ]
            ]
        ]


inputView : Model -> Html Msg
inputView model =
    let
        clearButton =
            if List.any (\x -> x.completed) model.list then
                button [ class "bg-blue-400 px-8 py-2 m-2 rounded text-xl text-black", onClick ClearCompleted ] [ text "Clear Completed" ]

            else
                span [] []
    in
    div [ class "m-auto" ]
        [ input [ class "border px-4 py-2 m-2 text-xl", onInput UpdateInput, value model.input, placeholder "Add a todo!" ] []
        , button [ class "bg-blue-400 px-8 py-2 m-2 rounded text-xl text-black", onClick AddTodo ] [ text "+" ]
        , clearButton
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
    div [ class "flex" ]
        [ div
            [ class "flex items-center mx-4", onClick (ToggleCompleted todo.id) ]
            [ input [ type_ "checkbox", checked todo.completed ] []
            , p [ class classes ] [ text todo.title ]
            ]
        , div [ class "flex items-center justify-center", onClick (DeleteTodo todo.id) ]
            [ p
                [ class "bg-red-600 text-white m-auto ml-2 w-4 h-4 text-xs rounded-full flex items-center justify-center" ]
                [ text "x" ]
            ]
        ]
