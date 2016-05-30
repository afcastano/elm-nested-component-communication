module Pair exposing (CounterPair, pairInit, pairView, PairMsg, pairUpdate, ManualUpdateMsg(Red), manualUpdate)

import Counter exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.App as App

(=>) : a -> b -> ( a, b )
(=>) = (,)

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
  div [ style ["background-color" => "lightgray", "margin-bottom" => "1rem"] ]
    [
      div []
        [
          div [][text <| "Total click count " ++ (toString model.totalClickCount)]
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
  | NoOp

type alias RedVal = Int
type alias GreenVal = Int

pairUpdate : PairMsg -> CounterPair -> (CounterPair, RedVal, GreenVal)
pairUpdate msg model =
  case msg of
    NoOp ->
      (model, Counter.getValue model.redCounter, Counter.getValue model.greenCounter)
    PairGreen sub ->
      let
        greenCounter = counterUpdate sub model.greenCounter
        model' = { model | greenCounter = greenCounter, totalClickCount = model.totalClickCount + 1 }
      in
        (model', Counter.getValue model'.redCounter, Counter.getValue model'.greenCounter)

    PairRed sub ->
      let
        redCounter = counterUpdate sub model.redCounter
        model' = { model | redCounter = redCounter, totalClickCount = model.totalClickCount + 1 }
      in
        (model', Counter.getValue model'.redCounter, Counter.getValue model'.greenCounter)

----- Interface helper

type ManualUpdateMsg
  = Red

manualUpdate: ManualUpdateMsg -> Int -> CounterPair -> CounterPair
manualUpdate msg value model =
  case msg of
    Red ->
      let
        redCounter = counterUpdate (SetNum value) model.redCounter
      in
        { model | redCounter = redCounter }
