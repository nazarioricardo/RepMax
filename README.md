# RepMax

Project that reads data input and uses it to calculate One Rep Max based on repititions and weight.

## Running RepMax

If it throws the error "module 'Charts' doesn't exist", go to the main build target -> Build Settings and remove 'Charts' from 'Embedded Binaries' and add it again.

## Interpretation of Data Set

### `struct Session`

When reading data from the input file, I assume that the same type of exercise on the same day is a single session. Because of this, the `Session` struct conforms to the `Equatable` protocol, where date and exercise name determine equality. A `Session` struct holds the data input (date, sets, reps, and weight) that yields the highest one rep max.

### `struct Exercise`

With the above assumption, the `Exercise` struct holds an array of sessions for an exercise over time. It also holds the latest one rep max.

## Architecture

RepMax most important class is the `DataManager`. It does all the heavy lifting. It reads the input, and sets all the relevant value types. Through delegation, it sets the data for the main `TableView` and the Chart Graph, and of course, it calculates the actual rep max with Brzycki's formula.
