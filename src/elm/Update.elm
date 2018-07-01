module Update exposing (..)

import Model exposing(..)
import Msgs exposing(..)
import Routing exposing (parseLocation)

import Widgets.TodoList as TodoList
import Widgets.IncrementalSearch as IncrementalSearch
import Widgets.TRPGDice as TRPGDice
import Widgets.ToggleInput as ToggleInput
import Widgets.Omikuji as Omikuji


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        OnLocationChange location ->
            let newRoute = parseLocation location in
            ({model | route = newRoute}, Cmd.none)
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