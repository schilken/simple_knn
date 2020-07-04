# simple_knn

Calculate k-nearest neighbours(knn) with a small subset of lodash with chaining capability

## Features

- Calculate knn 
- Simple Unit Testing

## Usage


```dart
import "package:simple_knn/simple_knn.dart";
import 'data.dart';

void main() {
  final testSetSize = 100;
  final List<List<num>> testSet = alldata.sublist(0, testSetSize);
  final List<List<num>> trainingSet = alldata.sublist(0, testSetSize);

  for (int k = 1; k < 7; k++) {
    var successes = testSet.where((List<num> testPoint) =>
        LodashChain.knn(trainingSet, LodashChain.initial(testPoint), k: k) ==
        testPoint.last);
    var accuracy = (successes.length / testSetSize) * 100;
    print("result for k=$k: $accuracy%");
  }
}
```

## Unit Testing

* ✓ constructor and shape two dimensions filled
* ✓ constructor and shape only one dimension filled
* ✓ constructor and shape only scalar
* ✓ slice two dimensions
* ✓ slice only one dimension filled
* ✓ slice only scalar
* ✓ lastInChain two dimensions
* ✓ lastInChain only one dimension filled
* ✓ lastInChain only scalar
* ✓ first two dimensions
* ✓ first only one dimension filled
* ✓ first only scalar
* ✓ sortByColumn two dimensions
* ✓ sortByColumn only one dimension filled
* ✓ sortByColumn only scalar
* ✓ size two dimensions
* ✓ size only one dimension filled
* ✓ size only scalar
* ✓ map two dimensions
* ✓ map only one dimension filled
* ✓ map only scalar
* ✓ filter two dimensions
* ✓ filter only one dimension filled
* ✓ filter only scalar
* ✓ countByToPairs two dimensions
* ✓ countByToPairs only one dimension filled
* ✓ countByToPairs only scalar
* ✓ zip two dimensions
* ✓ zip only one dimension filled
* ✓ zip only scalar
* ✓ sum two dimensions
* ✓ sum only one dimension filled
* ✓ sum only scalar
* ✓ distance chain distance chain
* ✓ cloning two dimensions filled
* ✓ cloning only one dimension filled
* ✓ cloning only scalar
* ✓ normalize two dimensions filled
* ✓ normalize only one dimension filled
* ✓ normalize only scalar
* ✓ static min and max min
* ✓ static min and max max
* ✓ static distance simple v1 and v2
* ✓ static distance simple v1 and v2
* ✓ static initial of array length 4
* ✓ static initial of array length 1
* ✓ knn knn



