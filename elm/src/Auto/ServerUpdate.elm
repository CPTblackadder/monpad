module Auto.ServerUpdate exposing (..)

import Auto.FullElement
import Auto.Layout
import Json.Decode
import Json.Decode.Pipeline


type ServerUpdate 
    = SetImageURL String String
    | SetLayout Auto.Layout.Layout
    | AddElement Auto.FullElement.FullElement
    | RemoveElement String


decode : Json.Decode.Decoder ServerUpdate
decode =
    Json.Decode.oneOf [ Json.Decode.field "setImageURL" (Json.Decode.succeed SetImageURL |>
    Json.Decode.Pipeline.custom (Json.Decode.index 0 Json.Decode.string) |>
    Json.Decode.Pipeline.custom (Json.Decode.index 1 Json.Decode.string))
    , Json.Decode.succeed SetLayout |>
    Json.Decode.Pipeline.required "setLayout" Auto.Layout.decode
    , Json.Decode.succeed AddElement |>
    Json.Decode.Pipeline.required "addElement" Auto.FullElement.decode
    , Json.Decode.succeed RemoveElement |>
    Json.Decode.Pipeline.required "removeElement" Json.Decode.string ]