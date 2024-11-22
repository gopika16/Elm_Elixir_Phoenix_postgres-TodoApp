module Decoder exposing (..)


import Entities exposing (Task)
import Json.Decode as Decode exposing (Decoder)
import Json.Decode.Pipeline exposing (required)


userDetailsDecoder : Decoder Task
userDetailsDecoder =
    Decode.succeed Task
        |> required "id" Decode.int
        |> required "is_complete" Decode.bool
        |> required "description" Decode.string


todoResponseDecoder : Decoder (List Task)
todoResponseDecoder =
    Decode.succeed identity
        |> required "todos" (Decode.list userDetailsDecoder)
