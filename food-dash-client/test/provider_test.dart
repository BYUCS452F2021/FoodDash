import 'package:flutter_test/flutter_test.dart';

void main() {
  test('String.trim() removes surrounding whitespace', () {
    var string = '  foo ';
    expect(string.trim(), equals('foo'));
  });
}
