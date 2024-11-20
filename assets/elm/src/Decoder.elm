module Decoder exposing (..)


import Entities exposing (Task, TodoResponse)
import Json.Decode as Decode exposing (Decoder)
import Json.Decode.Pipeline exposing (required)
import Json.Decode exposing (list)


userDetailsDecoder : Decoder Task
userDetailsDecoder =
    Decode.succeed Task
        |> required "id" Decode.int
        |> required "is_complete" Decode.bool
        |> required "description" Decode.string


-- todoResponseDecoder : Decoder TodoResponse
-- todoResponseDecoder =
--     Decode.succeed TodoResponse
--         |> required "status" Decode.string
--         |> required "todos" (Decode.list userDetailsDecoder)

todoResponseDecoder : Decoder (List Task)
todoResponseDecoder =
    Decode.succeed identity
        |> required "todos" (Decode.list userDetailsDecoder)
