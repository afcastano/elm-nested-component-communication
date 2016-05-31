module Pair exposing (Model, init, view, Msg(Red), update, getRedNum)

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
    [ div [][text <| "Total click count " ++ (toString model.totalClickCount)]
    , App.map PairGreen (Counter.view "green" model.greenCounter)
    , App.map PairRed (Counter.view "red" model.redCounter)
    ]

type Msg
  = PairRed Counter.Msg
  | PairGreen Counter.Msg
  | Red Model

update : Msg -> Model -> Model
update msg model =
  case msg of
    PairGreen sub ->
      { model | greenCounter = Counter.update sub model.greenCounter, totalClickCount = model.totalClickCount + 1 }

    PairRed sub ->
      { model | redCounter = Counter.update sub model.redCounter, totalClickCount = model.totalClickCount + 1 }

    Red modelOther ->
      { model | redCounter = Counter.update (Counter.SetNum modelOther.redCounter) model.redCounter }


------- INTEFACE HELPERS
getRedNum : Model -> Int
getRedNum model =
  Counter.getNum model.redCounter
