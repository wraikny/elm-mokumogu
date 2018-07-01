module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing(class, href, target)
import Html.Events exposing (onClick, onInput)
import Navigation

import Widgets.TodoList as TodoList
import Widgets.IncrementalSearch as IncrementalSearch
import Widgets.TRPGDice as TRPGDice
import Widgets.ToggleInput as ToggleInput
import Widgets.Omikuji as Omikuji


-- MAIN


main : Program Never Model Msg
main =
    program {
        init = init,
        view = view,
        update = update,
        subscriptions = subscriptions
    }



-- MODEL

type alias Model = {
        app : Apps,
        todoModel : TodoList.Model,
        incrModel : IncrementalSearch.Model,
        diceModel : TRPGDice.Model,
        toggModel : ToggleInput.Model,
        omkjModel : Omikuji.Model
    }


type Apps
    = Home
    | Todo
    | Incr
    | Dice
    | Togg
    | Omkj



-- UPDATE


type Msg
    = BackToHome
    | Change Apps
    | TodoMsg TodoList.Msg
    | IncMsg IncrementalSearch.Msg
    | DiceMsg TRPGDice.Msg
    | ToggMsg ToggleInput.Msg
    | OmkjMsg Omikuji.Msg



update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        BackToHome ->
            ({model | app = Home}, Navigation.newUrl "#home")
        Change app ->
            ({model | app = app}, Navigation.newUrl <| "#" ++ appShortName app)
        TodoMsg msg ->
            let (updated, cmd) =
                TodoList.update msg model.todoModel
            in
                ({model | todoModel = updated}, Cmd.map TodoMsg cmd)
        IncMsg msg ->
            let (updated, cmd) =
                IncrementalSearch.update msg model.incrModel
            in
                ({model | incrModel = updated}, Cmd.map IncMsg cmd)
        DiceMsg msg ->
            let (updated, cmd) =
                TRPGDice.update msg model.diceModel
            in
                ({model | diceModel = updated}, Cmd.map DiceMsg cmd)
        ToggMsg msg ->
            let (updated, cmd) =
                ToggleInput.update msg model.toggModel
            in
                ({model | toggModel = updated}, Cmd.map ToggMsg cmd)
        OmkjMsg msg ->
            let (updated, cmd) =
                Omikuji.update msg model.omkjModel
            in
                ({model | omkjModel = updated}, Cmd.map OmkjMsg cmd)



-- VIEW


view : Model -> Html Msg
view model =
    div [] [
        nav,
        div [class "ml2 mt2"] [
            let name = div [] <| appName model.app in
            case model.app of
                Home ->
                    div [class "home"] [
                        name,
                        p [] [
                            text "「Elmもくもぐ」(ハッシュタグ ",
                            a [
                                href "https://twitter.com/search?f=tweets&vertical=default&q=%23moku2_elm",
                                target "_blank"
                            ] [ text "#moku2_elm" ],
                            text ")のお題です。"
                        ],
                        list
                    ]
                Todo ->
                    div [class "todo"] [
                        name,
                        Html.map TodoMsg (TodoList.view model.todoModel)
                    ]
                Incr ->
                    div [class "incr"] [
                        name,
                        Html.map IncMsg (IncrementalSearch.view model.incrModel)
                    ]
                Dice ->
                    div [class "dice"] [
                        name,
                        Html.map DiceMsg (TRPGDice.view model.diceModel)
                    ]
                Togg ->
                    div [class "togg"] [
                        name,
                        Html.map ToggMsg (ToggleInput.view model.toggModel)
                    ]
                Omkj ->
                    div [class "omkj"] [
                        name,
                        Html.map OmkjMsg (Omikuji.view model.omkjModel)
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
apps = [Todo, Incr, Dice, Togg, Omkj]


appShortName : Apps -> String
appShortName app =
    case app of
        Home -> "home"
        Todo -> "todo"
        Incr -> "incr"
        Dice -> "dice"
        Togg -> "togg"
        Omkj -> "omkj"


appName : Apps -> List (Html Msg)
appName app = 
    let (name, icon) =
        case app of
        Home -> ("Home", "home")
        Todo -> ("ToDoList", "list-ul")
        Incr -> ("Incremental Search", "search")
        Dice -> ("TRPG Dice", "dice")
        Togg -> ("Toggle Input", "keyboard")
        Omkj -> ("Omikuji", "random")
    in
    [
        i [class <| "fa fa-" ++ icon ++ " mr1"] [],
        text name
    ]


list : Html Msg
list =
    div [class "p2"] [
        ul [] (apps |> List.map row)
    ]


row : Apps -> Html Msg
row app =
    li [] [
        button [
            class "btn regular",
            onClick <| Change app
        ] (appName app)
    ]


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


init : (Model, Cmd Msg)
init = 
    let (todoModel, _) = TodoList.init in
    let (incrModel, _) = IncrementalSearch.init in
    let (diceModel, _) = TRPGDice.init in
    let (toggModel, _) = ToggleInput.init in
    let (omkjModel, _) = Omikuji.init in
    (Model Home todoModel incrModel diceModel toggModel omkjModel, Cmd.none)
