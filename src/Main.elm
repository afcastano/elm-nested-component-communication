import Pair exposing (..)
import Totals exposing (..)

import Html exposing (..)
import Html.App as App exposing (beginnerProgram)

main : Program Never
main =
  beginnerProgram { model = init, view = view, update = update }

type alias Model =
  { pair1 : CounterPair
  , pair2 : CounterPair
  , totals: TotalsModel
  }

init : Model
init = Model pairInit pairInit totalsInit

view : Model -> Html Msg
view model =
  div []
    [
      div [][App.map (always NoOp) (totalsView model.totals)]
    , div [][App.map Pair1 (pairView model.pair1)]
    , div [][App.map Pair2 (pairView model.pair2)]
    ]


type Msg
  = NoOp
  | Pair1 PairMsg
  | Pair2 PairMsg

update : Msg -> Model -> Model
update msg model =
  case msg of
    NoOp ->
      model

    Pair1 sub ->
      let
        (pair1, redVal, greenVal) = pairUpdate sub model.pair1
        totals = totalsUpdate (UpdateRed redVal) model.totals
        pair2 = manualUpdate Red redVal model.pair2
      in
        { model | pair1 = pair1, totals = totals, pair2 = pair2}

    Pair2 sub ->
      let
        (pair2, redVal, greenVal) = pairUpdate sub model.pair2
        totals = totalsUpdate (UpdateRed redVal) model.totals
        pair1 = manualUpdate Red redVal model.pair1
      in
        { model | pair1 = pair1, totals = totals, pair2 = pair2}
