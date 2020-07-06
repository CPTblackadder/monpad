module Auto.FullElement exposing (..)

import Auto.Element
import Json.Decode
import Json.Decode.Pipeline
import Util.IntVector2


type alias FullElement  =
    { element : Auto.Element.Element
    , location : Util.IntVector2.IntVector2
    , name : String
    , showName : Bool }


decode : Json.Decode.Decoder FullElement
decode =
    Json.Decode.succeed FullElement |>
    Json.Decode.Pipeline.required "element" Auto.Element.decode |>
    Json.Decode.Pipeline.required "location" Util.IntVector2.decode |>
    Json.Decode.Pipeline.required "name" Json.Decode.string |>
    Json.Decode.Pipeline.required "showName" Json.Decode.bool