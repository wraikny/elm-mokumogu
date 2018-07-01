module Widgets.Omikuji exposing (Model, init, Msg, update, view)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick, onInput)


-- MODEL


type alias Model = {}


init : ( Model, Cmd Msg )
init =
    ( {}, Cmd.none )



-- UPDATE


type Msg
    = NoOp


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )


pattern : List String
pattern =
    [ "大吉", "吉", "中吉", "小吉", "末吉", "凶", "大凶" ]



-- VIEW


view : Model -> Html Msg
view model =
    div [] [
        div [] [
            
        ]
    ]