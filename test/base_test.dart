library lodash_chain.test.base;

import 'dart:math' as math;
import 'package:test/test.dart';
import 'package:lodash_chain/lodash_chain.dart';

void main([args, port]) {
  // setUpAll(() => null;

  // setUp(() => null);

  group('constructor and shape', () {
    test('two dimensions filled', () {
      final chain = LodashChain([
        [11, 12],
        [21, 22],
        [31, 32]
      ]);
      final shape = chain.valueShape;
      expect(shape, [3, 2]);
    });
    test('only one dimension filled', () {
      final chain = LodashChain.d1([
        11,
        22,
        33,
      ]);
      final shape = chain.valueShape;
      expect(shape, [3]);
    });
    test('only scalar', () {
      final chain = LodashChain.d0(
        11,
      );
      final shape = chain.valueShape;
      expect(shape.length, 0);
    });
  });

  group('slice', () {
    test('two dimensions', () {
      final chain = LodashChain([
        [11, 12],
        [21, 22],
        [31, 32],
        [41, 42]
      ]).slice(0, 2).value();
      expect(chain, [
        [11, 12],
        [21, 22],
      ]);
    });
    test('only one dimension filled', () {
      final chain = LodashChain.d1([
        11,
        22,
        33,
        44,
      ]).slice(0, 2).value();
      expect(chain, [11, 22]);
    });
    test('only scalar', () {
      expect(
          () => LodashChain.d0(
                11,
              ).slice(0, 1).value(),
          throwsException);
    });
  });

  group('last', () {
    test('two dimensions', () {
      final chain = LodashChain([
        [11, 12],
        [21, 22],
        [31, 32],
      ]).last().value();
      expect(
        chain,
        [31, 32],
      );
    });
    test('only one dimension filled', () {
      final chain = LodashChain.d1([
        11,
        22,
        33,
      ]).last().value();
      expect(chain, 33);
    });
    test('only scalar', () {
      expect(
          () => LodashChain.d0(
                11,
              ).slice(0, 1).value(),
          throwsException);
    });
  });

  group('first', () {
    test('two dimensions', () {
      final chain = LodashChain([
        [11, 12],
        [21, 22],
        [31, 32],
      ]).first().value();
      expect(chain, [
        11,
        12,
      ]);
    });
    test('only one dimension filled', () {
      final chain = LodashChain.d1([
        11,
        22,
        33,
      ]).first().value();
      expect(chain, 11);
    });
    test('only scalar', () {
      expect(
          () => LodashChain.d0(
                11,
              ).slice(0, 1).value(),
          throwsException);
    });
  });

  group('sortByColumn', () {
    test('two dimensions', () {
      final chain = LodashChain([
        [31, 32],
        [11, 12],
        [41, 42],
        [21, 22],
      ]).sortByColumn(0).value();
      expect(chain, [
        [11, 12],
        [21, 22],
        [31, 32],
        [41, 42],
      ]);
    });
    test('only one dimension filled', () {
      final chain = LodashChain.d1([
        22,
        11,
        44,
        33,
      ]).sortByColumn(0).value();
      expect(chain, [11, 22, 33, 44]);
    });
    test('only scalar', () {
      expect(
          () => LodashChain.d0(
                11,
              ).sortByColumn(0).value(),
          throwsException);
    });
  });

  group('size', () {
    test('two dimensions', () {
      final chain = LodashChain([
        [31, 32],
        [11, 12],
        [41, 42],
        [21, 22],
      ]).size().value();
      expect(chain, 4);
    });
    test('only one dimension filled', () {
      final chain = LodashChain.d1([
        22,
        11,
        44,
        33,
      ]).size().value();
      expect(chain, 4);
    });
    test('only scalar', () {
      expect(
          () => LodashChain.d0(
                11,
              ).size().value(),
          throwsException);
    });
  });

  group('map', () {
    test('two dimensions', () {
      final chain = LodashChain([
        [11, 12],
        [21, 22],
      ]).map((row) {
        return [2 * row[0], row[1]];
      }).value();
      expect(chain, [
        [22, 12],
        [42, 22],
      ]);
    });
    test('only one dimension filled', () {
      final chain = LodashChain.d1([
        11,
        22,
      ]).map((row) => 2 * row).value();
      expect(chain, [
        22,
        44,
      ]);
    });
    test('only scalar', () {
      expect(
          () => LodashChain.d0(
                11,
              ).size().value(),
          throwsException);
    });
  });

  group('filter', () {
    test('two dimensions', () {
      final chain = LodashChain([
        [11, 111],
        [122, 22],
        [33, 133],
      ]).filter((row) => row[0] < row[1]).value();
      expect(chain, [
        [11, 111],
        [33, 133],
      ]);
    });
    test('only one dimension filled', () {
      final chain = LodashChain.d1([
        10,
        11,
        22,
      ]).filter((row) => row < 15).value();
      expect(chain, [
        10,
        11,
      ]);
    });
    test('only scalar', () {
      expect(
          () => LodashChain.d0(
                11,
              ).size().value(),
          throwsException);
    });
  });

  group('countByToPairs', () {
    test('two dimensions', () {
      final chain = LodashChain([
        [1, 12],
        [2, 22],
        [1, 12],
        [1, 12],
        [3, 32],
      ]).countByToPairs(1).value();
      expect(chain, [
        [12, 3],
        [22, 1],
        [32, 1],
      ]);
    });
    test('only one dimension filled', () {
      final chain = LodashChain.d1([
        11,
        22,
        11,
        33,
        11,
      ]).countByToPairs(0).value();
      expect(chain, [
        [11, 3],
        [22, 1],
        [33, 1],
      ]);
    });
    test('only scalar', () {
      expect(
          () => LodashChain.d0(
                11,
              ).size().value(),
          throwsException);
    });
  });

  group('zip', () {
    test('two dimensions', () {
      final chain = LodashChain([
        [11, 12],
        [21, 22],
        [31, 32],
      ]).zip([1, 2, 3]).value();
      expect(chain, [
        [11, 12, 1],
        [21, 22, 2],
        [31, 32, 3],
      ]);
    });
    test('only one dimension filled', () {
      final chain = LodashChain.d1([
        11,
        22,
        33,
      ]).zip([1, 2, 3]).value();
      expect(chain, [
        [11, 1],
        [22, 2],
        [33, 3],
      ]);
    });
    test('only scalar', () {
      expect(
          () => LodashChain.d0(
                11,
              ).zip([1, 2, 3]).value(),
          throwsException);
    });
  });

  group('sum', () {
    test('two dimensions', () {
      final chain = LodashChain([
        [1, 3],
        [2, 4],
      ]).sum().value();
      expect(chain, 10);
    });
    test('only one dimension filled', () {
      final chain = LodashChain.d1([
        1,
        2,
        3,
      ]).sum().value();
      expect(chain, 6);
    });
    test('only scalar', () {
      expect(
          () => LodashChain.d0(
                11,
              ).sum().value(),
          throwsException);
    });
  });

  group('distance chain', () {
    test('distance chain', () {
      final chain = LodashChain.d1([
        1,
        2,
      ])
          .zip([4, 6])
          .map((row) => math.pow(row[0] - row[1], 2).toInt())
          .sum()
          .value();
      double distance = math.sqrt(chain);
      expect(distance, 5.0);
    });
  });

  group('min max', () {
    test('min', () {
      final min = LodashChain.min([
        5,
        3,
        1,
        2,
      ]);
      expect(min, 1);
    });

    test('max', () {
      final min = LodashChain.max([
        5,
        3,
        1,
        2,
      ]);
      expect(min, 5);
    });
  });

  group('cloning', () {
    test('two dimensions filled', () {
      final chain = LodashChain([
        [11, 12],
        [21, 22],
        [31, 32]
      ]);
      final shape = LodashChain.emptyClone(chain).valueShape;
      expect(shape, [3, 2]);
    });
    test('only one dimension filled', () {
      final chain = LodashChain.d1([
        11,
        22,
        33,
      ]);
      final shape = LodashChain.emptyClone(chain).valueShape;
      expect(shape, [3]);
    });
    test('only scalar', () {
      final chain = LodashChain.d0(
        11,
      );
      final shape = LodashChain.emptyClone(chain).valueShape;
      expect(shape.length, 0);
    });
  });

  group('normalize', () {
    test('two dimensions filled', () {
      final chain = LodashChain([
        [50, 5],
        [20, 2],
        [10, 1]
      ]).normalize(1).value();
      expect(chain, [
        [1, 5],
        [0.5, 2],
        [0, 1]
      ]);
    });
    test('only one dimension filled', () {
      final chain = LodashChain.d1([
        55,
        22,
        11,
      ]).normalize(1).value();
      final shape = LodashChain.emptyClone(chain).valueShape;
      expect(chain, [
        1,
        0.5,
        0,
      ]);
    });
    test('only scalar', () {
      final chain = LodashChain.d0(
        11,
      );
      final shape = LodashChain.emptyClone(chain).valueShape;
      expect(shape.length, 0);
    });
  });
}
