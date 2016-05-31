# Example of Sibling/Nested communication in [elm](http://elm-lang.org/).

The example tries to implement the accepted answer of this [StackOverflow question](http://stackoverflow.com/questions/37328203/elm-0-17-how-to-subscribe-to-sibling-nested-component-changes)

Please create [issues](https://github.com/afcastano/elm-nested-component-communication/issues) with any feedback or leave comments in the [SO](http://stackoverflow.com/questions/37328203/elm-0-17-how-to-subscribe-to-sibling-nested-component-changes) question.

### Problems:
- The parent component needs to know about the internals of the children. It is not scalable.

### Proposed solution:
- Each component will return the data the parent needs and also expose functions to update and access nested data.

## Key parts of the implementation

```Counter.elm``` exposes getValue method to return the value of the counter without knowing the internal structure:

```
getValue : CounterModel -> Int
getValue model =
  model.num
```

```Pair.elm``` exposes a new update function that will receive a new msg and a value:

```
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
```

Also, the normal update function returns extra data that includes the value of the counters:

```
type alias RedVal = Int
type alias GreenVal = Int

pairUpdate : PairMsg -> CounterPair -> (CounterPair, RedVal, GreenVal)
```

```Main.elm``` orchestrates the whole thing. Whenever a counter changes, it updates the other counter and the totals without knowing the internal structure of neither of them:

```
Pair1 sub ->
  let
    (pair1, redVal, greenVal) = pairUpdate sub model.pair1
    totals = totalsUpdate (UpdateRed redVal) model.totals
    pair2 = manualUpdate Red redVal model.pair2
  in
    { model | pair1 = pair1, totals = totals, pair2 = pair2}
```

## Running the example
To run it, simply do:

```
git clone git@bitbucket.org:afcastano/elm-nested-component-communication.git
cd elm-nested-component-communication
elm-reactor
```

go to http://localhost:8000/src/Main.elm
