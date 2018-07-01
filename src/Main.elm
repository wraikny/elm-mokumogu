module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing(class)
import Html.Events exposing (onClick, onInput)

import Widgets.TodoList as TodoList
import Widgets.IncrementalSearch as IncSearch


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
        todoModel : TodoList.Model,
        incModel : IncSearch.Model 
    }


type Apps
    = Home
    | Todo
    | Inc


type Msg
    = BackToHome
    | Change Apps
    | TodoMsg TodoList.Msg
    | IncMsg IncSearch.Msg



update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        BackToHome ->
            ({model | app = Home}, Cmd.none)
        Change app ->
            ({model | app = app}, Cmd.none)
        TodoMsg msg ->
            let
                (updatedTodoModel, todoCmd) =
                    TodoList.update msg model.todoModel
            in
                ({model | todoModel = updatedTodoModel}, Cmd.map TodoMsg todoCmd)
        IncMsg msg ->
            let
                (updatedIncModel, todoCmd) =
                    IncSearch.update msg model.incModel
            in
                ({model | incModel = updatedIncModel}, Cmd.map IncMsg todoCmd)



view : Model -> Html Msg
view model =
    div [] [
        nav,
        div [class "ml2 mt2"] [
            case model.app of
                Home ->
                    div [] [
                        div [] [
                            i [class "fa fa-home mr1"] [],
                            text "Home"
                        ],
                        list
                    ]
                Todo ->
                    div [] [
                        div [] [
                            i [class "fa fa-list-ul mr1"] [],
                            text "ToDoList"
                        ],
                        Html.map TodoMsg (TodoList.view model.todoModel)
                    ]
                Inc ->
                div [] [
                    div [] [
                            i [class "fa fa-search mr1"] [],
                            text "Incremental Search"
                        ],
                        Html.map IncMsg (IncSearch.view model.incModel)
                ]
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
                i [ class "fa fa-home mr1" ] [],
                text "Home"
            ]
        ]
    ]


list : Html Msg
list =
    div [class "p2"] [
        ul [] (
            [
                ("ToDoList", Change Todo, "list-ul"),
                ("Incremental Search", Change Inc, "search")
            ]
            |> List.map (\x -> row x)
        )
    ]



row : (String, Msg, String) -> Html Msg
row (appName, appMsg, btnType) =
    li [] [
        button [
            class "btn regular",
            onClick <| appMsg
        ] [
            i [class <| "fa fa-" ++ btnType ++ " mr1"] [],
            text appName
        ]
    ]




subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


init : (Model, Cmd Msg)
init = 
    let (todoModel, _) = TodoList.init in
    let (incModel, _) = IncSearch.init in
    (Model Home todoModel incModel, Cmd.none)
