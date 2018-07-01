module Routing exposing (..)

import Navigation exposing (Location)
import UrlParser exposing (..)

type Route
    = App String
    | NotFoundRoute


matchers : Parser (Route -> a) a
matchers =
    oneOf
        [ map App top
        , map App string
        ]

parseLocation : Location -> Route
parseLocation location =
    case (parseHash matchers location) of
        Just route ->
            route
        Nothing ->
            NotFoundRoute