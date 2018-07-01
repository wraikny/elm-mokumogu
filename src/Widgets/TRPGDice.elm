module Widgets.TRPGDice exposing (Model, init, Msg, update, view)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick, onInput)
import Random


-- MODEL


type alias Model = {
    dieFace : Int,
    diceNum : Int,
    diceMax : Int
}


init : ( Model, Cmd Msg )
init =
    (Model 1 1 6, Cmd.none)



-- UPDATE


type Msg
    = Roll
    | NewFace Int
    | InputNum String
    | InputMax String

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Roll ->
            ( model, Random.generate NewFace <| Random.int 1 <| model.diceNum * model.diceMax)
        NewFace newFace ->
            let face =
                List.range 0 (model.diceNum - 1)
                |> List.map (\x -> ((newFace // model.diceNum^x) % model.diceMax) + 1)
                |> List.foldl (+) 0
            in
            ( {model | dieFace = face}, Cmd.none )
        InputNum sn ->
            let n = String.toInt sn |> Result.withDefault 1 |> Basics.max 1
            in
                ( {model | diceNum = n}, Cmd.none )
        InputMax sn ->
            let n = String.toInt sn |> Result.withDefault 6 |> Basics.max 1
            in
                ( {model | diceMax = n}, Cmd.none )


-- VIEW

view : Model -> Html Msg
view model =
    div [] [
        h1 [class "ml2"] [
            text (toString model.dieFace)
        ],
        div [class "die-setting"] [
            input [
                class "die",
                type_ "number",
                value (toString model.diceNum),
                onInput InputNum
            ] [],
            span [class "mr2"] [text "d"],
            input [
                class "die",
                type_ "number",
                value (toString model.diceMax),
                onInput InputMax
            ] []
        ],
        button [
            class "btn regular",
            onClick Roll
        ] [
            i [ class "fa fa-dice mr1" ] [],
            text "Roll"
        ]
    ]