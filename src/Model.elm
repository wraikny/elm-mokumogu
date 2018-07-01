module Model exposing(..)

import Navigation

import Msgs exposing(..)

import Widgets.TodoList as TodoList
import Widgets.IncrementalSearch as IncrementalSearch
import Widgets.TRPGDice as TRPGDice
import Widgets.ToggleInput as ToggleInput
import Widgets.Omikuji as Omikuji

type alias Model = {
        history : List Navigation.Location,
        app : Apps,
        todoModel : TodoList.Model,
        incrModel : IncrementalSearch.Model,
        diceModel : TRPGDice.Model,
        toggModel : ToggleInput.Model,
        omkjModel : Omikuji.Model
    }


init : Navigation.Location -> (Model, Cmd Msg)
init location = 
    let (todoModel, _) = TodoList.init in
    let (incrModel, _) = IncrementalSearch.init in
    let (diceModel, _) = TRPGDice.init in
    let (toggModel, _) = ToggleInput.init in
    let (omkjModel, _) = Omikuji.init in
    (Model [location] Home todoModel incrModel diceModel toggModel omkjModel, Cmd.none)