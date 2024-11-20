module Model exposing (..)

import Entities exposing (Task)
import Msg exposing (Msg)
import Msg exposing (Msg(..))
import Http
import Decoder exposing (todoResponseDecoder)


type alias Model =
    { allTasks : List Task
    , newTask : Maybe String
    , editingTaskId : Maybe Int
    , editingTaskDescription : String
    , lastId : Int
    , warning : Maybe String
    , filterTask : Bool
    , deleteTaskId : Int
    }


initialModel : () -> ( Model, Cmd Msg )
initialModel _ =
    ( { allTasks = []
      , newTask = Nothing
      , editingTaskId = Nothing
      , editingTaskDescription = ""
      , lastId = 3
      , warning = Nothing
      , filterTask = False
      , deleteTaskId = 0
      }
    , fetchTasks
    )


fetchTasks : Cmd Msg
fetchTasks =
    Http.get
        { url = "http://localhost:4000/todos"
        , expect = Http.expectJson LoadData todoResponseDecoder
        }