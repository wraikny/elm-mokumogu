module Widgets.TRPGDice exposing (Model, init, Msg, update, view)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick, onInput)
import Random


-- MODEL


type alias Model = {
    dieFace : Int,
    dieNum : Int,
    dieMax : Int
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
update msg ({dieNum, dieMax} as model) =
    case msg of
        Roll ->
            ( model, Random.generate NewFace <| Random.int 1 <| dieNum * dieMax)
        NewFace newFace ->
            let face =
                List.range 0 (dieNum - 1)
                |> List.map (\x -> ((newFace // dieNum^x) % dieMax) + 1)
                |> List.sum
            in
            ( {model | dieFace = face}, Cmd.none )
        InputNum sn ->
            let n = String.toInt sn |> Result.withDefault 1 |> Basics.max 1
            in
                ( {model | dieNum = n}, Cmd.none )
        InputMax sn ->
            let n = String.toInt sn |> Result.withDefault 6 |> Basics.max 1
            in
                ( {model | dieMax = n}, Cmd.none )



-- VIEW


view : Model -> Html Msg
view {dieFace, dieNum, dieMax} =
    div [] [
        h1 [class "ml2"] [
            text (toString dieFace)
        ],
        div [class "die-setting"] [
            input [
                class "die",
                type_ "number",
                value (toString dieNum),
                onInput InputNum
            ] [],
            span [class "mr2"] [text "d"],
            input [
                class "die",
                type_ "number",
                value (toString dieMax),
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