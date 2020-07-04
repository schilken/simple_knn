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
