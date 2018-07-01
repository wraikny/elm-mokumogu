module Msgs exposing (..)

import Navigation exposing (Location)

import Widgets.TodoList as TodoList
import Widgets.IncrementalSearch as IncrementalSearch
import Widgets.TRPGDice as TRPGDice
import Widgets.ToggleInput as ToggleInput
import Widgets.Omikuji as Omikuji


type Msg
    = OnLocationChange Location
    | TodoMsg TodoList.Msg
    | IncMsg IncrementalSearch.Msg
    | DiceMsg TRPGDice.Msg
    | ToggMsg ToggleInput.Msg
    | OmkjMsg Omikuji.Msg