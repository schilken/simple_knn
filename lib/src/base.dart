part of lodash_chain;

/// The root of the console API
class LodashChain {
  static bool initialized = false;

  int currentDim;

  List<List<num>> dim2data;
  List<num> dim1data;
  num dim0data;

  LodashChain(this.dim2data) : currentDim = 2;

  LodashChain.d1(this.dim1data) : currentDim = 1;
//        dim1data = dim1numdata.map((numVal) => numVal.toInt()).toList();

  LodashChain.d0(this.dim0data) : currentDim = 0;

  LodashChain.emptyClone(LodashChain object) {
    final shape = object.valueShape;
    switch (object.currentDim) {
      case 0:
        currentDim = 0;
        break;
      case 1:
        dim1data = List<num>()..length = shape[0];
        currentDim = 1;
        break;
      case 2:
        dim2data = [];
        for (int row = 0; row < shape[0]; row++) {
          dim2data.add(List<num>()..length = shape[1]);
        }
        currentDim = 2;
        break;
    }
  }

  LodashChain slice([int start = 0, int end = 0]) {
    switch (currentDim) {
      case 0:
        throw Exception('slice on scalar not defined');
        break;
      case 1:
        dim1data = dim1data.sublist(start, end);
        break;
      case 2:
        dim2data = dim2data.sublist(start, end);
        ;
    }
    return this;
  }

  LodashChain last() {
    switch (currentDim) {
      case 0:
        throw Exception('slice on scalar not defined');
        break;
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
        break;
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
        break;
      case 1:
        dim1data.sort();
        break;
      case 2:
        dim2data.sort((a, b) => a[index].compareTo(b[index]));
        ;
    }
    return this;
  }

  LodashChain size() {
    switch (currentDim) {
      case 0:
        throw Exception('size on scalar not defined');
        break;
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
        break;
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
          if (result is int) {
            tmp1data.add(result);
          } else {
            List<num> newRow = fn(row).cast<int>();
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
        break;
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
        break;
      case 1:
        Map<int, int> counterMap = {};
        dim1data.forEach((row) {
          counterMap[row] = (counterMap[row] ?? 0) + 1;
        });
        dim1data.clear();
        dim2data = [];
        counterMap.forEach((k, v) => dim2data.add([k, v]));
        currentDim = 2;
        break;
      case 2:
        Map<int, int> counterMap = {};
        dim2data.forEach((row) {
          counterMap[row[index]] = (counterMap[row[index]] ?? 0) + 1;
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
        break;
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
        break;
      case 1:
        return dim1data;
        break;
      case 2:
        return dim2data;
    }
  }

  LodashChain sum() {
    switch (currentDim) {
      case 0:
        throw Exception('countByToPairs on scalar not defined');
        break;
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
        break;
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

  List<num> get valueShape {
    switch (currentDim) {
      case 0:
        return [];
        break;
      case 1:
        return [dim1data.length];
        break;
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

  @override
  String toString() => "???";
}
