module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing(class)
import Html.Events exposing (onClick, onInput)

import Widgets.TodoList as TodoList


main : Program Never Model Msg
main =
    program {
        init = init,
        view = view,
        update = update,
        subscriptions = subscriptions
    }


type alias Model = {
        app : Apps,
        todoModel : TodoList.Model
    }


type Apps
    = Home
    | Todo


type Msg
    = BackToHome
    | TodoMsg TodoList.Msg



update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        BackToHome ->
            ({model | app = Home}, Cmd.none)
        TodoMsg TodoList.New ->
            ({model | app = Todo}, Cmd.none)
        TodoMsg msg ->
            let
                (updatedTodoModel, todoCmd) =
                    TodoList.update msg model.todoModel
            in
                ({model | todoModel = updatedTodoModel}, Cmd.map TodoMsg todoCmd)



view : Model -> Html Msg
view model =
    div [] [
        nav,
        div [class "ml2 mt2"] [
            case model.app of
                Home ->
                    list
                
                Todo ->
                    Html.map TodoMsg (TodoList.view model.todoModel)
        ]
    ]


nav : Html Msg
nav =
    div [class "clearfix mb2 white bg-black"] [
        div [class "left p2"] [
            button [
                class "btn regular",
                onClick BackToHome
            ] [
                i [ class "fa fa-home mr1" ] [
                    text "Home"
                ]
            ]
        ] 
    ]


list : Html Msg
list =
    div [class "p2"] [
        div [] [text "Widgets"],
        table [] [
            tbody [] (
                [
                    ("ToDoList", TodoMsg TodoList.New, "list-ul")
                ]
                |> List.map (\x -> row x)
            )
        ]
    ]



row : (String, Msg, String) -> Html Msg
row (appName, appMsg, btnType) =
    tr [] [
        td [] [text appName],
        td [] [
            button [
                class "btn regular",
                onClick <| appMsg
            ] [
                i [class <| "fa fa-" ++ btnType ++ " mr1"] []
            ]
        ]
    ]




subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


init : (Model, Cmd Msg)
init = 
    let (todoModel, _) = TodoList.init in
    (Model Home todoModel, Cmd.none)
