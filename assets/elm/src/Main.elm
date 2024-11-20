module Main exposing (main)

import Browser
import Model exposing (Model, initialModel)
-- import Msg exposing (Msg)
import Update exposing (update)
import View exposing (view)



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
