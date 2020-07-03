# lodash_chain

Subset of lodash methods with chaining

## Features

- tt
- Simple Unit Testing

## Usage

This library does not work in browsers (for a hopefully obvious reason).

```dart
import "package:lodash_chain/lodash_chain.dart";

void main() {
  // Initialize the Console. Throws an exception if advanced terminal features are not supported.
  Console.init();
  
  // Use the library...
}
```

## Unit Testing

You can test the output produced by this library (and thus your own project that uses this library). Here is an example:

```dart
import "package:test/test.dart";
import "package:lodash_chain/lodash_chain.dart";

void main() {
  final output = new BufferConsoleAdapter();

  setUpAll(() => Console.adapter = output);

  // Clear output between test runs
  setUp(() => output.clear());

  group('base functions', () {
    test('centerCursor', () {
      Console.centerCursor();
      expect(output.toString(), '${Console.ANSI_ESCAPE}10;40H');
    });
  });
}
```
