module Routing exposing (..)

import Navigation exposing (Location)
import UrlParser exposing (..)


type Route
    = Home
    | Todo
    | Incr
    | Dice
    | Togg
    | Omkj
    | NotFoundRoute


matchers : Parser (Route -> a) a
matchers =
    oneOf
    [ map Home top
    , map Home (s "home")
    , map Todo (s "todo")
    , map Incr (s "incr")
    , map Dice (s "dice")
    , map Togg (s "togg")
    , map Omkj (s "omkj")
    ]

parseLocation : Location -> Route
parseLocation location =
    case (parseHash matchers location) of
        Just route ->
            route
        
        Nothing ->
            NotFoundRoute