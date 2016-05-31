import Pair
import Totals

import Html exposing (..)
import Html.App as App exposing (beginnerProgram)

main : Program Never
main =
  beginnerProgram { model = init, view = view, update = update }

type alias Model =
  { pair1 : Pair.Model
  , pair2 : Pair.Model
  , totals: Totals.Model
  }

init : Model
init = Model Pair.init Pair.init Totals.init

view : Model -> Html Msg
view model =
  div []
    [ App.map (always NoOp) (Totals.view model.totals)
    , App.map Pair1 (Pair.view model.pair1)
    , App.map Pair2 (Pair.view model.pair2)
    ]

type Msg
  = NoOp
  | Pair1 Pair.Msg
  | Pair2 Pair.Msg

update : Msg -> Model -> Model
update msg model =
  case msg of
    NoOp ->
      model

    Pair1 sub ->
      let
        pair1 = Pair.update sub model.pair1
        totals = Totals.update (Totals.UpdateRed <| Pair.getRedNum pair1) model.totals
        pair2 = Pair.update (Pair.UpdateRed <| Pair.getRedNum pair1) model.pair2
      in
        { model | pair1 = pair1, pair2 = pair2, totals = totals }

    Pair2 sub ->
      let
        pair2 = Pair.update sub model.pair2
        totals = Totals.update (Totals.UpdateRed <| Pair.getRedNum pair2) model.totals
        pair1 = Pair.update (Pair.UpdateRed <| Pair.getRedNum pair2) model.pair1
      in
        { model | pair1 = pair1, pair2 = pair2, totals = totals }
