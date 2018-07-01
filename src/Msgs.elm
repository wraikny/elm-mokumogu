module Msgs exposing (..)

import Navigation

import Widgets.TodoList as TodoList
import Widgets.IncrementalSearch as IncrementalSearch
import Widgets.TRPGDice as TRPGDice
import Widgets.ToggleInput as ToggleInput
import Widgets.Omikuji as Omikuji


type Apps
    = Home
    | Todo
    | Incr
    | Dice
    | Togg
    | Omkj


type Msg
    = UrlChange Navigation.Location
    | Change Apps
    | TodoMsg TodoList.Msg
    | IncMsg IncrementalSearch.Msg
    | DiceMsg TRPGDice.Msg
    | ToggMsg ToggleInput.Msg
    | OmkjMsg Omikuji.Msg