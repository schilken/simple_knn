part of simple_knn;

/// The root of the console API
class LodashChain {
  static bool initialized = false;

  late int currentDim;

  late List<List<num>> dim2data;
  late List<num> dim1data;
  late num dim0data;

  LodashChain(this.dim2data)
      : currentDim = 2,
        dim1data = [],
        dim0data = 0;

  LodashChain.d1(this.dim1data)
      : currentDim = 1,
        dim2data = [[]],
        dim0data = 0;

  LodashChain.d0(this.dim0data)
      : currentDim = 0,
        dim2data = [[]],
        dim1data = [];

  LodashChain.emptyClone(LodashChain object) {
    final shape = object.valueShape;
    switch (object.currentDim) {
      case 0:
        currentDim = 0;
        dim2data = [];
        dim1data = [];
        dim0data = 0;
        break;
      case 1:
        dim1data = List.filled(shape[0], 0);
        currentDim = 1;
        dim2data = [];
        dim0data = 0;
        break;
      case 2:
        dim0data = 0;
        dim1data = [];
        dim2data = [];
        for (int row = 0; row < shape[0]; row++) {
          dim2data.add(List.filled(shape[1], 0));
        }
        currentDim = 2;
        break;
    }
  }

  LodashChain slice([int start = 0, int end = 0]) {
    switch (currentDim) {
      case 0:
        throw Exception('slice on scalar not defined');
      case 1:
        dim1data = dim1data.sublist(start, end);
        break;
      case 2:
        dim2data = dim2data.sublist(start, end);
        ;
    }
    return this;
  }

  LodashChain lastInChain() {
    switch (currentDim) {
      case 0:
        throw Exception('slice on scalar not defined');
      case 1:
        dim0data = dim1data.last;
        currentDim = 0;
        break;
      case 2:
        dim1data = dim2data.last;
        currentDim = 1;
        ;
    }
    return this;
  }

  LodashChain first() {
    switch (currentDim) {
      case 0:
        throw Exception('slice on scalar not defined');
      case 1:
        dim0data = dim1data.first;
        dim1data.clear();
        currentDim = 0;
        break;
      case 2:
        dim1data = dim2data.first;
        dim2data.clear();
        currentDim = 1;
        ;
    }
    return this;
  }

  LodashChain sortByColumn(int index) {
    switch (currentDim) {
      case 0:
        throw Exception('sortByColumn on scalar not defined');
      case 1:
        dim1data.sort();
        break;
      case 2:
        dim2data
            .sort((List<num> a, List<num> b) => a[index].compareTo(b[index]));
        ;
    }
    return this;
  }

  LodashChain size() {
    switch (currentDim) {
      case 0:
        throw Exception('size on scalar not defined');
      case 1:
        dim0data = dim1data.length;
        currentDim = 0;
        break;
      case 2:
        dim0data = dim2data.length;
        currentDim = 0;
    }
    return this;
  }

  LodashChain map(Function fn) {
    switch (currentDim) {
      case 0:
        throw Exception('map on scalar not defined');
      case 1:
        List<num> tmp1data = [];
        dim1data.forEach((row) {
          int newRow = fn(row);
          tmp1data.add(newRow);
        });
        dim1data = tmp1data;
        break;
      case 2:
        List<List<num>> tmp2data = [];
        List<num> tmp1data = [];
        dim2data.forEach((row) {
          var result = fn(row);
//          var type = result.runtimeType;
          if (result is num) {
            tmp1data.add(result);
          } else {
            List<num> newRow = fn(row).cast<num>();
            tmp2data.add(newRow);
          }
        });
        if (tmp1data.length > 0) {
          dim1data = tmp1data;
          currentDim = 1;
        } else {
          dim2data = tmp2data;
        }
    }
    return this;
  }

  LodashChain filter(Function fn) {
    switch (currentDim) {
      case 0:
        throw Exception('filter on scalar not defined');
      case 1:
        dim1data = dim1data.where((row) => fn(row)).toList();
        break;
      case 2:
        dim2data = dim2data.where((row) => fn(row)).toList();
    }
    return this;
  }

  LodashChain countByToPairs(int index) {
    switch (currentDim) {
      case 0:
        throw Exception('countByToPairs on scalar not defined');
      case 1:
        Map<num, num> counterMap = {};
        dim1data.forEach((row) {
          counterMap[row] = (counterMap[row] ?? 0) + 1;
        });
        dim1data.clear();
        dim2data = [];
        counterMap.forEach((k, v) => dim2data.add([k, v]));
        currentDim = 2;
        break;
      case 2:
        Map<num, num> counterMap = {};
        dim2data.forEach((List<num> row) {
          num value = row[index];
          counterMap[value] = (counterMap[value] ?? 0) + 1;
        });
        dim2data.clear();
        counterMap.forEach((k, v) => dim2data.add([k, v]));
    }
    return this;
  }

  LodashChain zip(List<num> array) {
    switch (currentDim) {
      case 0:
        throw Exception('countByToPairs on scalar not defined');
      case 1:
        if (dim1data.length != array.length) {
          throw Exception('length of array differs from wrapped data');
        }
        dim2data = [];
        for (int ix = 0; ix < dim1data.length; ix++) {
          dim2data.add([dim1data[ix], array[ix]]);
        }
        dim1data.clear();
        currentDim = 2;
        break;
      case 2:
        if (dim2data.length != array.length) {
          throw Exception('length of array differs from wrapped data');
        }
        for (int ix = 0; ix < dim2data.length; ix++) {
          dim2data[ix] = [...dim2data[ix], array[ix]];
        }
    }
    return this;
  }

  dynamic value() {
    switch (currentDim) {
      case 0:
        return dim0data;
      case 1:
        return dim1data;
      case 2:
        return dim2data;
    }
  }

  LodashChain sum() {
    switch (currentDim) {
      case 0:
        throw Exception('countByToPairs on scalar not defined');
      case 1:
        dim0data = dim1data.reduce((acc, elt) => acc + elt);
        dim1data.clear();
        currentDim = 0;
        break;
      case 2:
        dim0data = 0;
        if (dim2data.length > 0) {
          for (int row = 0; row < dim2data.length; row++) {
            for (int col = 0; col < dim2data[0].length; col++) {
              dim0data += dim2data[row][col];
            }
          }
        }
        dim2data.clear();
        currentDim = 0;
        break;
    }
    return this;
  }

  LodashChain normalize(int numColumns) {
    switch (currentDim) {
      case 0:
        throw Exception('normalize on scalar not defined');
      case 1:
        var minValue = dim1data
            .reduce((num acc, num element) => element < acc ? element : acc);
        var maxValue = dim1data
            .reduce((num acc, num element) => element > acc ? element : acc);
        var deltaValue = maxValue - minValue;
        for (int ix = 0; ix < dim1data.length; ix++) {
          dim1data[ix] = (dim1data[ix] - minValue) / deltaValue;
        }
        break;
      case 2:
        for (int col = 0; col < numColumns; col++) {
          List<num> column = dim2data.map((List<num> row) => row[col]).toList();
          var minValue = column
              .reduce((num acc, num element) => element < acc ? element : acc);
          var maxValue = column
              .reduce((num acc, num element) => element > acc ? element : acc);
          var deltaValue = maxValue - minValue;
          for (int ix = 0; ix < dim2data.length; ix++) {
            dim2data[ix][col] = (dim2data[ix][col] - minValue) / deltaValue;
          }
        }
    }
    return this;
  }

  List<int> get valueShape {
    switch (currentDim) {
      case 0:
        return [];
      case 1:
        return [dim1data.length];
      case 2:
        final rows = dim2data.length;
        final cols = rows > 0 ? dim2data[0].length : 0;
        return [rows, cols];
    }
    return [];
  }

  static num listMin(List<num> data) {
    return data.reduce((acc, element) => element < acc ? element : acc);
  }

  static num listMax(List<num> data) {
    return data.reduce((acc, elt) => elt > acc ? elt : acc);
  }

  static num distance(List<num> v1, List<num> v2) {
    final chain = LodashChain.d1(v1)
        .zip(v2)
        .map((row) => math.pow(row[0] - row[1], 2))
        .sum()
        .value();
    return math.sqrt(chain);
  }

  static List<num> initial(List<num> input) {
    if (input.length < 2) {
      return [];
    }
    return input.sublist(0, input.length - 1);
  }

  static num? last(List<num> input) {
    if (input.length < 1) {
      return null;
    }
    return input.last;
  }

  static num knn(List<List<num>> trainingSet, List<num> testPoint,
      {int k = 0}) {
    return LodashChain(trainingSet)
        .map((row) {
          return [distance(initial(row), testPoint), LodashChain.last(row)];
        })
        .sortByColumn(0)
        .slice(0, k)
        .countByToPairs(1)
        .sortByColumn(1)
        .lastInChain()
        .first()
        .value();
  }

  @override
  String toString() => "???";
}
