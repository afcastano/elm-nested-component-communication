module Counter exposing (CounterModel, counterUpdate, counterInit, counterView, CounterMsg(SetNum), getValue)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)

type alias CounterModel =
  { num : Int
  , btnClicks : Int
  }

counterInit num =
  CounterModel num 0

counterView color model =
  div [ style [("display","inline-block"), ("margin-right", "1rem")] ]
    [ button [ onClick Decrement ] [ text "-" ]
    , div [ style [("color", color)]] [ text (toString model.num) ]
    , button [ onClick Increment ] [ text "+" ]
    , div [ ] [ text ("btn click: " ++ (toString model.btnClicks)) ]
    ]

type CounterMsg
  = NoOp
  | Increment
  | Decrement
  | SetNum Int

counterUpdate : CounterMsg -> CounterModel -> CounterModel
counterUpdate msg model =
  case msg of
    NoOp ->
      model
    Increment ->
      { model | num = model.num + 1, btnClicks = model.btnClicks + 1 }

    Decrement ->
      { model | num = model.num - 1, btnClicks = model.btnClicks + 1 }

    SetNum num ->
      {model | num = num}

------- INTEFACE HELPERS
getValue : CounterModel -> Int
getValue model =
  model.num
