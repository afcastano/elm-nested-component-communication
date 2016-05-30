module Totals exposing (TotalsModel, totalsInit, totalsView, TotalsMsg(UpdateRed), totalsUpdate)

import Html exposing (..)
import Html.Attributes exposing (..)

(=>) : a -> b -> ( a, b )
(=>) = (,)

type alias TotalsModel =
  { redNum : Int,
    foo: String
  }

totalsInit : TotalsModel
totalsInit =
  TotalsModel 0 "Foo"

totalsView : TotalsModel -> Html TotalsMsg
totalsView model =
  div [style ["color" => "red"]][text <| "Red val: " ++ (toString model.redNum)]

type TotalsMsg
  = NoOp
  | UpdateRed Int

totalsUpdate : TotalsMsg -> TotalsModel -> TotalsModel
totalsUpdate msg model =
  case msg of
    NoOp ->
      model
    UpdateRed redNum ->
      { model | redNum = redNum }
