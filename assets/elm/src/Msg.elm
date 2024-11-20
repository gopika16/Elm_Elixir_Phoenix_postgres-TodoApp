module Msg exposing (..)
import Entities exposing (Task)
import Http


type Msg
    = AddTask
    | NewTask String
    | ToggleTask Int
    | EditTask Int
    | SaveEditedTask Int
    | SaveDescription String 
    | Reset
    | FilterTask 
    | FetchData
    | LoadData (Result Http.Error (List Task))
    | DeleteTask Int
    | TaskDeleted (Result Http.Error String)
    | TaskUpdated (Result Http.Error String)

