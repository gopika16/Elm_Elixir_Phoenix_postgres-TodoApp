module Main exposing (main)

import Browser
import Model exposing (Model, initialModel)
import Update exposing (update)
import View exposing (view)
import Msg exposing (Msg)



main : Program () Model Msg
main =
    Browser.element
        { init = initialModel
        , subscriptions = subscriptions
        , view = view
        , update = update
        }


subscriptions : Model -> Sub msg
subscriptions _ =
    Sub.none
