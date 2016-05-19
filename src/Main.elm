import Counter exposing (..)
import Pair exposing (..)
import Totals exposing (..)

import Html exposing (..)
import Html.App as App exposing (beginnerProgram)
import Html.Events exposing (onClick)
import Html.Attributes exposing (style)

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

toPair2Msg: PairMsg -> Msg
toPair2Msg pairMsg = Pair2 pairMsg

fireUpdate: Model -> Msg -> Model
fireUpdate model msg = update msg model

update : Msg -> Model -> Model
update msg model =
  case msg of
    NoOp ->
      model

    Pair1 sub ->
      let
        pair1 = pairUpdate sub model.pair1
        totals = totalsUpdate (UpdateRed pair1.redCounter.num) model.totals
        pair2 = pairUpdate (SetRed (SetNum pair1.redCounter.num)) model.pair2
      in
        { model | pair1 = pair1, totals = totals, pair2 = pair2}

    Pair2 sub ->
      let
        pair2 = pairUpdate sub model.pair2
        totals = totalsUpdate (UpdateRed pair2.redCounter.num) model.totals
        pair1 = pairUpdate (SetRed (SetNum pair2.redCounter.num)) model.pair1
      in
        { model | pair1 = pair1, totals = totals, pair2 = pair2}
