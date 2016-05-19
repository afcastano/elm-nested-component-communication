module Counter exposing (..)

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
  | External CounterExternalMsg


type CounterExternalMsg
    = SetNum Int

counterExternalUpdate: CounterExternalMsg -> CounterModel -> CounterModel
counterExternalUpdate msg model =
  case msg of
    SetNum num -> {model | num = num}

counterUpdate : CounterMsg -> CounterModel -> CounterModel
counterUpdate msg model =
  case msg of
    NoOp ->
      model
    Increment ->
      let
        model' = { model | num = model.num + 1, btnClicks = model.btnClicks + 1 }
      in
        model'

    Decrement ->
      let
        model' = { model | num = model.num - 1, btnClicks = model.btnClicks + 1 }
      in
        model'

    External externalMsg ->
      counterExternalUpdate externalMsg model
