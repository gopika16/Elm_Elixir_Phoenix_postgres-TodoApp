module View exposing (view)

import Entities exposing (Task)
import Html exposing (Html, button, div, h1, img, input, p, table, tbody, td, text, th, thead, tr)
import Html.Attributes exposing (checked, src, style, type_, value)
import Html.Events exposing (onClick, onInput)
import Maybe exposing (withDefault)
import Model exposing (Model)
import Msg exposing (Msg(..))


view : Model -> Html Msg
view model =
    div
        [ style "margin" "40%"
        , style "margin-top" "10%"
        , style "color" "white"
        -- , onMouseLeave Reset
        ]
        [ h1 [] [ text "Todo Tasks" ]
        , p [ style "color" "red" ] [ text (withDefault "" model.warning) ]
        , input
            [ onInput NewTask
            , style "width" "150px"
            , style "height" "15px"
            , value (Maybe.withDefault "" model.newTask)
            ]
            []
        , button
            [ onClick AddTask
            , style "font-size" "15px"
            , style "background-color" "white"
            ]
            [ text "Add Task" ]
        , button
            [ onClick FilterTask
            , style "font-size" "15px"
            , style "background-color" "white"
            ]
            [ text "Show Completed" ]
        , button
            [ onClick Reset
            , style "font-size" "15px"
            , style "background-color" "white"
            ]
            [ text "save" ]
        , table
            [ style "letter-spacing" "1px"
            , style "border" "2px solid black"
            , style "width" "19%"
            , style "margin-top" "15%"
            ]
            [ thead []
                [ tr []
                    [ th [] [ text "Status" ]
                    , th [] [ text "Description" ]
                    ]
                ]
            , tbody []
                (List.map (getFilteredRows model.filterTask model.editingTaskId) model.allTasks)
            ]
        ]


getFilteredRows : Bool -> Maybe Int -> Task -> Html Msg
getFilteredRows isComplete editingTaskId task =
    if isComplete then
        if task.isComplete then
            getTableRow editingTaskId task

        else
            text ""
    else
        getTableRow editingTaskId task


getTableRow : Maybe Int -> Task -> Html Msg
getTableRow editingTaskId data =
    tr
        [ style "background-color" "black" ]
        [ td [ style "padding" "5px" ]
            [ input
                [ type_ "checkbox"
                , checked data.isComplete
                , onClick (ToggleTask data.id)
                ]
                []
            ]
        , td
            [ style "padding" "5px"
            , style "text-decoration"
                (if data.isComplete then
                    "line-through"

                 else
                    "none"
                )
            ]
            [ if Just data.id == editingTaskId then
                input
                    [ type_ "text"
                    , value data.description
                    , onInput SaveEditedTask
                    ]
                    []

              else
                text data.description
            ]
        , td [ style "padding" "5px" ]
            [ button
                [ onClick (EditTask data.id)
                , style "border" "none"
                , style "cursor" "pointer"
                ]
                [ img
                    [ src "https://banner2.cleanpng.com/20190518/ost/kisspng-computer-icons-scalable-vector-graphics-editing-cl-edit-svg-png-icon-free-download-252434-online-1713892319098.webp"
                    , style "width" "20px"
                    , style "height" "20px"
                    ]
                    []
                ]
            ]
        , td [ style "padding" "5px" ]
            [ button
                [ onClick (DeleteTask data.id)
                , style "border" "none"
                , style "cursor" "pointer"
                ]
                [ img
                    [ src "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTZ-C7xd5t5WaAiTd43G1xmKb9vYK2uDmaqvg&s"
                    , style "width" "20px"
                    , style "height" "20px"
                    ]
                    []
                ]
            ]
        -- , td [ style "padding" "5px" ]
        --     [ button
        --         [ onClick Reset
        --         , style "border" "none"
        --         , style "cursor" "pointer"
        --         ]
        --         [ text "save" ]
        --     ]
        ]
