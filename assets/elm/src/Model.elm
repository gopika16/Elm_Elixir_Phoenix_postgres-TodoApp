module Model exposing (..)

import Entities exposing (Task)


type alias Model =
    { allTasks : List Task
    , newTask : Maybe String
    , editingTaskId : Maybe Int
    , lastId : Int
    , warning :Maybe String
    , filterTask : Bool
    }


initialModel : Model
initialModel =
    { allTasks =
        [ { id = 1
          , isComplete = True
          , description = "Task 1"
          }
        , { id = 2
          , isComplete = False
          , description = "Task 2"
          }
        , { id = 3
          , isComplete = True
          , description = "Task 3"
          }
        ]
    , newTask = Nothing
    , editingTaskId = Nothing
    , lastId = 3
    , warning = Nothing
    , filterTask = False
    }
