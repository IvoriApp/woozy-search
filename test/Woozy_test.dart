import 'package:woozy_search/woozy_search.dart';
import 'package:test/test.dart';
import 'package:uuid/uuid.dart';

void main() {
  group('Basic tests', () {
    final woozy = Woozy();

    setUp(() {
      woozy.setEntries(['foo', 'bar']);
    });

    test('first test', () {
      final records = woozy.search('foo');
      expect(records.length, 2);

      // perfect match return score 1.0
      final firstRecord = records.first;
      expect(firstRecord.score, 1.0);
      expect(firstRecord.text, 'foo');

      // worst match return score 0.0
      final secondRecord = records.last;
      expect(secondRecord.score, 0.0);
      expect(secondRecord.text, 'bar');
    });

    test('empty query', () {
      final records = woozy.search('');
      expect(records.length, 2);
    });

    test('associated value should be `null`', () {
      final records = woozy.search('foo');
      expect(records.length, 2);

      final firstRecord = records.first;
      expect(firstRecord.value, null);

      final secondRecord = records.last;
      expect(secondRecord.value, null);
    });
  });

  group('Long and short queries', () {
    final woozy = Woozy();

    setUp(() {
      woozy.setEntries(['sun', 'sunflower']);
    });

    test('In favor of shorter word when query is short', () {
      final records = woozy.search('su');
      expect(records.first.text, 'sun');
      expect(records.last.text, 'sunflower');
    });

    test('In favor of longer word when query is long', () {
      final records = woozy.search('lots of sunflowers');
      expect(records.first.text, 'sunflower');
      expect(records.last.text, 'sun');
    });
  });

  group('Limit the number of matches output', () {
    test('Positive number', () {
      final woozy = Woozy(limit: 5);
      woozy.addEntries(List.filled(10, 'Foo'));
      final records = woozy.search('Foo');
      expect(records.length, 5);
    });

    test('Zero', () {
      expect(() => Woozy(limit: 0), throwsA(isA<AssertionError>()));
    });

    test('Negative number', () {
      expect(() => Woozy(limit: -5), throwsA(isA<AssertionError>()));
    });
  });

  group('Associated values', () {
    test('`null` values', () {
      final woozy = Woozy();

      woozy.addEntry('foo');
      woozy.addEntry('bar');
      final records = woozy.search('f');
      expect(records.first.value, null);
    });

    test('integers', () {
      final woozy = Woozy();

      woozy.addEntry('foo', value: 0);
      woozy.addEntry('bar', value: 1);
      final records = woozy.search('f');
      expect(records.first.value, 0);
    });

    test('UUIDs', () {
      final woozy = Woozy();
      final fooId = Uuid();
      final barId = Uuid();

      woozy.addEntry('foo', value: fooId);
      woozy.addEntry('bar', value: barId);
      final records = woozy.search('f');
      expect(records.first.value, fooId);
    });
  });

  group('Case sensitivity', () {
    test('case insensitive', () {
      final woozy = Woozy();
      woozy.addEntries(['FOO', 'Boo']);
      final records = woozy.search('foo');
      expect(records.first.text, 'FOO');
    });

    test('case insensitive', () {
      final woozy = Woozy(caseSensitive: true);
      woozy.addEntries(['FOO', 'Boo']);
      final records = woozy.search('foo');
      expect(records.first.text, 'Boo');
    });
  });
}
