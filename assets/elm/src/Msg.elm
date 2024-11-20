module Msg exposing (..)


type Msg
    = AddTask
    | NewTask String
    | ToggleTask Int
    | DeleteTask Int
    | EditTask Int
    | SaveEditedTask String
    | Reset
    | FilterTask
