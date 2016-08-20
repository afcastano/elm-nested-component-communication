# Example of Sibling/Nested component communication in [elm](http://elm-lang.org/).

The example tries to implement the accepted answer of this [StackOverflow question](http://stackoverflow.com/questions/37328203/elm-0-17-how-to-subscribe-to-sibling-nested-component-changes)

Please create [issues](https://github.com/afcastano/elm-nested-component-communication/issues) with any feedback or leave comments in the [SO](http://stackoverflow.com/questions/37328203/elm-0-17-how-to-subscribe-to-sibling-nested-component-changes) question.

### Working example:
http://afcastano.github.io/elm-nested-component-communication/

### Problem:
- I have one parent component with two children. With the Elm Architecture, how can I update the right child when any of the counters in the left child change? Avoid the parent component to know about the internals of the children since it is not scalable.

### Proposed solution:
- Each component will provide functions to access the data the parent needs and also expose Msg to update nested data. In this way, the parent component only need to know about the exposed functions and Msg of the direct child.

## Key parts of the implementation

```Counter.elm``` exposes ```getNum``` function to return the value of the counter without knowing the internal structure 
and a new ```SetNum``` Msg to update it:
```elm
type Msg
    = Increment
    | Decrement
    | SetNum Int
```
...
```elm
getNum : Model -> Int
getNum model =
    model.num
```

```Pair.elm``` also exposes a function to return the red number:
```elm
getRedNum : Model -> Int
getRedNum model =
    Counter.getNum model.redCounter
```
and a new update Msg that is propagated to the update function of the Counter.
```elm
type Msg
    = PairRed Counter.Msg
    | PairGreen Counter.Msg
    | UpdateRed Int


update : Msg -> Model -> Model
update msg model =
    case msg of
        UpdateRed value ->
            { model | redCounter = Counter.update (Counter.SetNum value) model.redCounter }
```

```Main.elm``` orchestrates the whole thing. Whenever a counter changes, it updates the other counter and the totals without knowing the internal structure of neither of them:

```elm
Pair1 subMsg ->
    let
        pair1 =
            Pair.update subMsg model.pair1

        totals =
            Totals.update (Totals.UpdateRed <| Pair.getRedNum pair1) model.totals

        pair2 =
            Pair.update (Pair.UpdateRed <| Pair.getRedNum pair1) model.pair2
    in
        Model pair1 pair2 totals
```

## Running the example
To run it, simply do:

```
git clone git@github.com:afcastano/elm-nested-component-communication.git
cd elm-nested-component-communication
elm-reactor
```
go to ```http://localhost:8000/src/Main.elm```

---
Thanks to [rofrol](https://github.com/rofrol) for all the corrections made to this example.
