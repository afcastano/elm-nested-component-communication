module Pair exposing (..)
import Counter exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.App as App


type alias CounterPair =
  { greenCounter : CounterModel
  , redCounter : CounterModel
  , totalClickCount : Int
  }

pairInit : CounterPair
pairInit =
  CounterPair (counterInit 0) (counterInit 0) 0

pairView : CounterPair -> Html PairMsg
pairView model =
  div [ style [("background-color","lightgray"), ("margin-bottom", "1rem")] ]
    [
      div []
        [
          div [][text ("Total click count " ++ toString(model.totalClickCount))]
        ]
    ,  countersView model
    ]

countersView: CounterPair -> Html PairMsg
countersView model =
  div []
    [
      App.map PairGreen (counterView "green" model.greenCounter)
    , App.map PairRed (counterView "red" model.redCounter)
    ]


type PairMsg
  = PairRed CounterMsg
  | PairGreen CounterMsg
  | SetRed CounterExternalMsg
  | NoOp

pairUpdate : PairMsg -> CounterPair -> CounterPair
pairUpdate msg model =
  case msg of
    NoOp ->
      model
    PairGreen sub ->
      let
        greenCounter = counterUpdate sub model.greenCounter
      in
        { model | greenCounter = greenCounter, totalClickCount = model.totalClickCount + 1 }

    PairRed sub ->
      let
        redCounter = counterUpdate sub model.redCounter
      in
        { model
        | redCounter = redCounter
        , totalClickCount = model.totalClickCount + 1
        }
    SetRed sub ->
      let
        redCounter = counterExternalUpdate sub model.redCounter
      in
        { model
        | redCounter = redCounter
        }
