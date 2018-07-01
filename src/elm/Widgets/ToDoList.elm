module Widgets.TodoList exposing (Model, init, Msg, update, view)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick, onInput)


-- MODEL


type alias TodoId = Int


type alias Model = {
        task: String, 
        todos: List (TodoId, String),
        nextid: TodoId
    }


init : (Model, Cmd Msg)
init = (Model "" [(0, "sample")] 1, Cmd.none)



-- UPDATE


type Msg
    = InputText String
    | AddTask
    | RemoveTodo TodoId


update : Msg -> Model -> ( Model, Cmd Msg )
update msg ({task, todos, nextid} as model) =
    case msg of
        InputText inputTask ->
            ({model | task = inputTask}, Cmd.none)
        AddTask -> 
            (Model "" ((nextid, task) :: todos) (nextid + 1), Cmd.none)
        RemoveTodo id ->
            let
                newTodos = todos |> List.filter (\(x, _) -> x /= id)
            in
                let newNextId =
                    case newTodos |> List.map (\(x, _) -> x) |> List.maximum of
                        Just id -> id + 1
                        Nothing -> 0
                in
                    ({model | todos = newTodos, nextid = newNextId}, Cmd.none)



-- VIEW


view : Model -> Html Msg
view {task, todos} =
    div [] [
        div [class "p1"] [
            input [
                placeholder "New Task",
                value task,
                onInput InputText
            ] [],
            button [
                class "btn regular",
                onClick AddTask
            ] [
                i [ class "fa fa-plus-circle mr1" ] []
            ]
        ],
        list todos
    ]


list : List (TodoId, String) -> Html Msg
list todos =
    div [class "p2"] [
        table [] [tbody []
            (todos |> List.reverse |> List.map todoRow)
        ]
    ]


todoRow : (TodoId, String) -> Html Msg
todoRow (id, todo) =
    tr [] [
        td [] [text todo],
        td [] [
            button [
                class "btn regular",
                onClick <| RemoveTodo id
            ] [
                i [ class "fa fa-trash-alt mr1" ] []
            ]
        ]
    ]