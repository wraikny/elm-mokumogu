module View exposing (view)

import Html exposing (..)
import Html.Attributes exposing(class, href, target)

import Model exposing(..)
import Msgs exposing(..)
import Routing exposing (Route(..))

import Widgets.TodoList as TodoList
import Widgets.IncrementalSearch as IncrementalSearch
import Widgets.TRPGDice as TRPGDice
import Widgets.ToggleInput as ToggleInput
import Widgets.Omikuji as Omikuji


view : Model -> Html Msg
view model =
    div [] [
        nav,
        div [class "ml2 mt2"] [
            let name = div [] <| appName model.route in
            case model.route of
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
                NotFoundRoute ->
                    div [] [
                        text "Not found"
                    ]
        ]
    ]


nav : Html Msg
nav =
    div [class "clearfix mb2 white bg-black"] [
        div [class "left p2"] [
            a [
                href "#/home",
                class "btn regular"
            ] (
                appName Home
            )
        ]
    ]


apps : List Route
apps = [Todo, Incr, Dice, Togg, Omkj]


appShortName : Route -> String
appShortName app =
    case app of
        Home -> "home"
        Todo -> "todo"
        Incr -> "incr"
        Dice -> "dice"
        Togg -> "togg"
        Omkj -> "omkj"
        NotFoundRoute -> "notfound"


appName : Route -> List (Html Msg)
appName app = 
    let (name, icon) =
        case app of
        Home -> ("Home", "home")
        Todo -> ("ToDoList", "list-ul")
        Incr -> ("Incremental Search", "search")
        Dice -> ("TRPG Dice", "dice")
        Togg -> ("Toggle Input", "keyboard")
        Omkj -> ("Omikuji", "random")
        NotFoundRoute -> ("Not Found", "times-hexagon")
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


row : Route -> Html Msg
row app =
    li [] [
        a [
            href <| "#/" ++ (appShortName app),
            class "btn regular"
        ] (appName app)
    ]
