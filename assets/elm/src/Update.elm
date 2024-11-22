module Update exposing (update)

import Debug exposing (toString)
import Decoder exposing (todoResponseDecoder)
import Entities exposing (Task)
import Http
import Json.Encode as JE
import Model exposing (..)
import Msg exposing (..)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        AddTask ->
            case model.newTask of
                Just aTask ->
                    let
                        newTask =
                            { id = 0
                            , isComplete = False
                            , description = aTask
                            }
                    in
                    ( { model | newTask = Nothing }
                    , addTask newTask
                    )

                Nothing ->
                    ( model, Cmd.none )

        NewTask newTask ->
            if String.trim newTask == "" then
                ( { model
                    | newTask = Nothing
                  }
                , Cmd.none
                )

            else
                ( { model
                    | newTask = Just newTask
                  }
                , Cmd.none
                )

        ToggleTask id ->
            let
                tasks =
                    List.head (List.filter (\t -> t.id == id) model.allTasks)
            in
            case tasks of
                Just task ->
                    ( model, editTask { task | isComplete = not task.isComplete } )

                Nothing ->
                    ( model, Cmd.none )

        EditTask id ->
            ( { model | editingTaskId = Just id }, Cmd.none )

        SaveEditedTask savingTaskId ->
            case model.editingTaskId of
                Just id ->
                    let
                        updatedTasks =
                            List.head (List.filter (\t -> t.id == id && id == savingTaskId) model.allTasks)
                    in
                    case updatedTasks of
                        Just task ->
                            ( model, editTask task )

                        Nothing ->
                            ( model, Cmd.none )

                Nothing ->
                    ( model, Cmd.none )

        Reset ->
            ( { model
                | editingTaskId = Nothing
                , warning = Nothing
              }
            , Cmd.none
            )

        FilterTask ->
            ( { model | filterTask = not model.filterTask }, Cmd.none )

        FetchData ->
            ( model
            , fetchTasks
            )

        LoadData results ->
            case results of
                Ok result ->
                    ( { model | allTasks = result }, Cmd.none )

                Err error ->
                    let
                        _ =
                            Debug.log "er" error
                    in
                    ( { model | warning = Just "Error occured" }, Cmd.none )

        DeleteTask taskId ->
            ( { model | deleteTaskId = taskId }, deleteTask taskId )

        TaskDeleted (Ok _) ->
            ( { model | allTasks = List.filter (\task -> task.id /= model.deleteTaskId) model.allTasks }, Cmd.none )

        TaskDeleted (Err _) ->
            ( { model | warning = Just "Unable to delete task" }
            , Cmd.none
            )

        TaskUpdated result ->
            case result of
                Ok _ ->
                    ( { model
                        | editingTaskId = Nothing
                        , warning = Nothing
                      }
                    , fetchTasks
                    )

                Err _ ->
                    ( model, Cmd.none )

        SaveDescription newDescription ->
            case model.editingTaskId of
                Just id ->
                    let
                        updatedTasks =
                            List.map (updateTaskDescription id newDescription) model.allTasks
                    in
                    if newDescription /= "" then
                        ( { model
                            | allTasks = updatedTasks
                            , warning = Nothing
                          }
                        , Cmd.none
                        )

                    else
                        ( { model | warning = Just "Task Cannot be empty" }, Cmd.none )

                Nothing ->
                    ( model, Cmd.none )


updateTaskDescription : Int -> String -> Task -> Task
updateTaskDescription id newDescription task =
    if task.id == id then
        { task | description = newDescription }

    else
        task


fetchTasks : Cmd Msg
fetchTasks =
    Http.get
        { url = "http://localhost:4000/todos"
        , expect = Http.expectJson LoadData todoResponseDecoder
        }


deleteTask : Int -> Cmd Msg
deleteTask taskId =
    Http.request
        { method = "DELETE"
        , headers = []
        , url = "http://localhost:4000/deleteTask/" ++ toString taskId
        , body = Http.emptyBody
        , expect = Http.expectString TaskUpdated
        -- , expect = Http.expectString TaskDeleted
        , timeout = Nothing
        , tracker = Nothing
        }


editTask : Task -> Cmd Msg
editTask task =
    Http.request
        { method = "PUT"
        , headers = []
        , url = "http://localhost:4000/editTask"
        , body =
            Http.jsonBody
                (JE.object
                    [ ( "id", JE.int task.id )
                    , ( "description", JE.string task.description )
                    , ( "isComplete", JE.bool task.isComplete )
                    ]
                )
        , expect = Http.expectString TaskUpdated
        , timeout = Nothing
        , tracker = Nothing
        }


addTask : Task -> Cmd Msg
addTask task =
    Http.post
        { url = "http://localhost:4000/createTask"
        , body =
            Http.jsonBody
                (JE.object
                    [ ( "description", JE.string task.description )
                    , ( "isComplete", JE.bool task.isComplete )
                    ]
                )
        , expect = Http.expectString TaskUpdated
        }
