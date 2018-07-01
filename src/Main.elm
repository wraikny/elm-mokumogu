module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing(class)
import Html.Events exposing (onClick, onInput)

import Widgets.TodoList as TodoList
import Widgets.IncrementalSearch as IncSearch
import Widgets.TRPGDice as TRPGDice


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
        incModel : IncSearch.Model,
        diceModel : TRPGDice.Model
    }


type Apps
    = Home
    | Todo
    | Inc
    | Dice


type Msg
    = BackToHome
    | Change Apps
    | TodoMsg TodoList.Msg
    | IncMsg IncSearch.Msg
    | DiceMsg TRPGDice.Msg



update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        BackToHome ->
            ({model | app = Home}, Cmd.none)
        Change app ->
            ({model | app = app}, Cmd.none)
        TodoMsg msg ->
            let (updated, cmd) =
                TodoList.update msg model.todoModel
            in
                ({model | todoModel = updated}, Cmd.map TodoMsg cmd)
        IncMsg msg ->
            let (updated, cmd) =
                IncSearch.update msg model.incModel
            in
                ({model | incModel = updated}, Cmd.map IncMsg cmd)
        DiceMsg msg ->
            let (updated, cmd) =
                TRPGDice.update msg model.diceModel
            in
                ({model | diceModel = updated}, Cmd.map DiceMsg cmd)




view : Model -> Html Msg
view model =
    div [] [
        nav,
        div [class "ml2 mt2"] [
            case model.app of
                Home ->
                    div [] [
                        div [] (
                            appName Home
                        ),
                        list
                    ]
                Todo ->
                    div [] [
                        div [] (
                            appName Todo
                        ),
                        Html.map TodoMsg (TodoList.view model.todoModel)
                    ]
                Inc ->
                    div [] [
                        div [] (
                            appName Inc
                        ),
                        Html.map IncMsg (IncSearch.view model.incModel)
                    ]
                Dice ->
                    div [] [
                        div [] (
                            appName Dice
                        ),
                        Html.map DiceMsg (TRPGDice.view model.diceModel)
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
            ] (
                appName Home
            )
        ]
    ]


apps : List Apps
apps = [
        Todo,
        Inc,
        Dice
    ]


appName : Apps -> List (Html Msg)
appName app = 
    let (name, icon) =
        case app of
        Home -> ("Home", "home")
        Todo -> ("ToDoList", "list-ul")
        Inc -> ("Incremental Search", "search")
        Dice -> ("TRPGDice", "dice")
    in
    [
        i [class <| "fa fa-" ++ icon ++ " mr1"] [],
        text name
    ]


list : Html Msg
list =
    div [class "p2"] [
        ul [] (
            apps
            |> List.map (\x -> row <| x)
        )
    ]



row : Apps -> Html Msg
row app =
    li [] [
        button [
            class "btn regular",
            onClick <| Change app
        ] (
            appName app
        )
    ]




subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


init : (Model, Cmd Msg)
init = 
    let (todoModel, _) = TodoList.init in
    let (incModel, _) = IncSearch.init in
    let (diceModel, _) = TRPGDice.init in
    (Model Home todoModel incModel diceModel, Cmd.none)
