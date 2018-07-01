module Main exposing (..)

import Navigation

import Html exposing (..)
import Html.Attributes exposing(class, href, target)
import Html.Events exposing (onClick, onInput)

import Model exposing(..)
import Msgs exposing(..)
import Update exposing(..)
import View exposing(..)

import Widgets.TodoList as TodoList
import Widgets.IncrementalSearch as IncrementalSearch
import Widgets.TRPGDice as TRPGDice
import Widgets.ToggleInput as ToggleInput
import Widgets.Omikuji as Omikuji


-- MAIN


main : Program Never Model Msg
main =
    Navigation.program OnLocationChange {
        init = init,
        view = view,
        update = update,
        subscriptions = subscriptions
    }



subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none
