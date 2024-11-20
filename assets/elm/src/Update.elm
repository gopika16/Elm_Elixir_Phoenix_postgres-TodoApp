module Update exposing (update)

import Entities exposing (Task)
import Model exposing (..)
import Msg exposing (..)


update : Msg -> Model -> Model
update msg model =
    case msg of
        AddTask ->
            case model.newTask of
                Just aTask ->
                    let
                        newTask =
                            { id = model.lastId + 1
                            , isComplete = False
                            , description = aTask
                            }
                    in
                    { model
                        | allTasks = newTask :: model.allTasks
                        , newTask = Nothing
                        , lastId = model.lastId + 1
                    }

                Nothing ->
                    model

        NewTask newTask ->
            if String.trim newTask == "" then
                { model
                    | newTask = Nothing
                }

            else
                { model
                    | newTask = Just newTask
                }

        ToggleTask id ->
            let
                updatedTasks =
                    List.map (updateTaskStatus id) model.allTasks
            in
            { model | allTasks = updatedTasks }

        DeleteTask id ->
            { model | allTasks = List.filter (\task -> task.id /= id) model.allTasks }

        EditTask id ->
            { model | editingTaskId = Just id }

        SaveEditedTask newDescription ->
            case model.editingTaskId of
                Just id ->
                    let
                        updatedTasks =
                            List.map (updateTaskDescription id newDescription) model.allTasks
                    in
                    if newDescription /= "" then
                        { model
                            | allTasks = updatedTasks
                            , warning = Nothing
                        }

                    else
                        { model | warning = Just "Task Cannot be empty" }

                Nothing ->
                    model

        Reset ->
            { model
                | editingTaskId = Nothing
                , warning = Nothing
            }

        FilterTask ->
            { model | filterTask = not model.filterTask }


updateTaskDescription : Int -> String -> Task -> Task
updateTaskDescription id newDescription task =
    if task.id == id then
        { task | description = newDescription }

    else
        task


updateTaskStatus : Int -> Task -> Task
updateTaskStatus id task =
    if task.id == id then
        let
            updatedTask =
                { task | isComplete = not task.isComplete }
        in
        updatedTask

    else
        task
