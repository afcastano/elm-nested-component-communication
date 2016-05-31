module Counter exposing (Model, update, init, view, Msg(SetNum), getValue)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)

(=>) : a -> b -> ( a, b )
(=>) = (,)

type alias Model =
  { num : Int
  , btnClicks : Int
  }

init : Int -> Model
init num =
  Model num 0

view : String -> { c | btnClicks : a, num : b } -> Html Msg
view color model =
  div [ style ["display" => "inline-block", "margin-right" => "1rem"] ]
    [ button [ onClick Increment ] [ text "+" ]
    , div [ style ["color" => color]] [ text <| toString model.num ]
    , button [ onClick Decrement ] [ text "-" ]
    , div [ ] [ text <| "btn click: " ++ (toString model.btnClicks) ]
    ]

type Msg
  = Increment
  | Decrement
  | SetNum Int

update : Msg -> Model -> Model
update msg model =
  case msg of
    Increment ->
      { model | num = model.num + 1, btnClicks = model.btnClicks + 1 }

    Decrement ->
      { model | num = model.num - 1, btnClicks = model.btnClicks + 1 }

    SetNum num ->
      {model | num = num}

------- INTEFACE HELPERS
getValue : Model -> Int
getValue model =
  model.num
