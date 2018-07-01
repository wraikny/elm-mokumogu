module Widgets.ToggleInput exposing (Model, init, Msg, update, view)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick, onInput)
import Array


-- MODEL


type alias Model = {
    text : String,
    index : Int,
    key : Key
}


init : ( Model, Cmd Msg )
init =
    ({
        text = "こんにちは　えるむ",
        index = 0,
        key = Enter
    }
    , Cmd.none )



-- UPDATE


type Msg
    = InputKey Key


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        InputKey key ->
            let (text, index) =
                if key == model.key then
                    let index = (model.index + 1) % (keys key |> List.length) in
                    if index == model.index then
                        addText model
                    else
                        (model.text, index)
                else
                    addText model
            in
                ( {text = text, key = key, index = index}, Cmd.none )


addText : Model -> ( String, Int)
addText model =
    let array = keys model.key |> Array.fromList in
        let s = case array |> Array.get model.index of
            Just a -> a
            Nothing -> ""
        in
            (model.text ++ s, 0)

-- VIEW


view : Model -> Html Msg
view model =
    div [class "togg-all"] [
        div [class "display"] [
            textarea [
                class "display-text",
                readonly True,
                wrap "hard",
                value (
                    let c = case keys model.key |> Array.fromList |> Array.get model.index of
                        Just a -> a
                        Nothing -> ""
                    in
                    model.text ++ c
                )
            ] []
        ],
        div [class "keyboard"] (
            Enter :: (List.range 1 9 |> List.map Num) ++ [Asterisk, Num 0, Sharp]
            |> List.map makeBtn
        )
    ]


type Key
    = Enter
    | Num Int
    | Asterisk
    | Sharp


keys : Key -> List String
keys key =
    let s = case key of
        Enter -> ""
        Num 1 -> "あいうえお"
        Num 2 -> "かきくけこ"
        Num 3 -> "さしすせそ"
        Num 4 -> "たちつてと"
        Num 5 -> "なにぬねの"
        Num 6 -> "はひふへほ"
        Num 7 -> "まみむめも"
        Num 8 -> "やゆよ"
        Num 9 -> "らりるれろ"
        Num 0 -> "わをん"
        Num _ -> ""
        Asterisk -> "*"
        Sharp -> "#"
    in
        let list = s |> String.split ""
        in
            if (list |> List.length) == 0 then
                list ++ [""]
            else list


btnKey : Key -> String
btnKey key =
    case key of
        Enter -> "□"
        _ -> case keys key |> List.head of
            Just a -> a
            Nothing -> ""



makeBtn : Key -> Html Msg
makeBtn key =
    button [
        class (
        let n = case key of
            Enter -> "return "
            _ -> ""
        in n ++ "button btn regular"),
        onClick <| InputKey key
    ] [
        span [
            class ("icon" ++ case key of
                Enter -> " is-medium"
                _ -> ""
            )
        ] [
            text <| (
                let n = case key of
                    Num x -> toString x ++ " "
                    _ -> ""
                in n ++ (btnKey key)
            )
        ]
    ]