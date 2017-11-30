# RepMax

Project that reads data input and uses it to calculate One Rep Max based on repititions and weight.

## Running RepMax

If it throws the error "module 'Charts' doesn't exist", go to the main build target -> Build Settings and remove 'Charts' from 'Embedded Binaries' and add it again.

## Architecture, and Interpretation of Data Set

### `struct Session`

When reading data from the input file, I assume that the same type of exercise on the same day is a single session. Because of this, the `Session` struct conforms to the `Equatable` protocol, where date and exercise name determine equality. A `Session` struct holds the data input (date, sets, reps, and weight) that yields the highest one rep max.

### `struct Exercise`

With the above assumption, the `Exercise` struct holds an array of sessions for a specific type of exercise (I.E bench press, shoulder press) over time. It also holds the latest one rep max for it's type of exercise.

### `class DataManager`

RepMax most important class is the `DataManager`. It does all the heavy lifting. It reads the input, and sets all the relevant value types. Through delegation, it sets the data for the main `TableView` and the Chart Graph, and of course, it calculates the actual rep max with Brzycki's formula.

## Improvements

There is always room for improvement! But if I waited until the app was perfect I would have never sent it over.

### User Inteface

The current UI is very barebones.

1. Animating the tableView.reloadData() would be a great first step to have a smoother experience.

2. Some typography, and editing of the Chart will go a long way as well. So basically, general UI design work.

### Interactivity

1. Scaling the chart would help for, errr... scalability. As it is now, the chart holds every session for that exercise ever, which is fine at the moment considering the amount of sessions remains around 30 with this data file, however, limits should be set. Ideally different limit sets, like the app RobinHood.

2. Logging new exercise through the app is a great start.
