module Entities exposing (..)


type alias Task =
    { id : Int
    , isComplete : Bool
    , description : String
    }

type alias TodoResponse =
    { status : String
    , todos : List Task
    }
