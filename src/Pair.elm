module Pair exposing (Model, init, view, Msg, update, ManualUpdateMsg(Red), manualUpdate)

import Counter

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.App as App

(=>) : a -> b -> ( a, b )
(=>) = (,)

type alias Model =
  { greenCounter : Counter.Model
  , redCounter : Counter.Model
  , totalClickCount : Int
  }

init : Model
init =
  Model (Counter.init 0) (Counter.init 0) 0

view : Model -> Html Msg
view model =
  div [ style ["background-color" => "lightgray", "margin-bottom" => "1rem"] ]
    [
      div []
        [
          div [][text <| "Total click count " ++ (toString model.totalClickCount)]
        ]
    ,  countersView model
    ]

countersView: Model -> Html Msg
countersView model =
  div []
    [
      App.map PairGreen (Counter.view "green" model.greenCounter)
    , App.map PairRed (Counter.view "red" model.redCounter)
    ]

type Msg
  = PairRed Counter.Msg
  | PairGreen Counter.Msg
  | NoOp

type alias RedVal = Int
type alias GreenVal = Int

update : Msg -> Model -> (Model, RedVal, GreenVal)
update msg model =
  case msg of
    NoOp ->
      (model, Counter.getValue model.redCounter, Counter.getValue model.greenCounter)
    PairGreen sub ->
      let
        greenCounter = Counter.update sub model.greenCounter
        model' = { model | greenCounter = greenCounter, totalClickCount = model.totalClickCount + 1 }
      in
        (model', Counter.getValue model'.redCounter, Counter.getValue model'.greenCounter)

    PairRed sub ->
      let
        redCounter = Counter.update sub model.redCounter
        model' = { model | redCounter = redCounter, totalClickCount = model.totalClickCount + 1 }
      in
        (model', Counter.getValue model'.redCounter, Counter.getValue model'.greenCounter)

----- Interface helper

type ManualUpdateMsg
  = Red

manualUpdate: ManualUpdateMsg -> Int -> Model -> Model
manualUpdate msg value model =
  case msg of
    Red ->
      let
        redCounter = Counter.update (Counter.SetNum value) model.redCounter
      in
        { model | redCounter = redCounter }
