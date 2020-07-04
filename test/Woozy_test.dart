import 'package:WoozySearch/WoozySearch.dart';
import 'package:test/test.dart';
import 'package:uuid/uuid.dart';

void main() {
  group('Basic tests', () {
    final woozy = Woozy();

    setUp(() {
      woozy.set_entries(['foo', 'bar']);
    });

    test('first test', () {
      final records = woozy.search('foo');
      expect(records.length, 2);

      // perfect match return score 1.0
      final first_record = records.first;
      expect(first_record.score, 1.0);
      expect(first_record.text, 'foo');

      // worst match return score 0.0
      final second_record = records.last;
      expect(second_record.score, 0.0);
      expect(second_record.text, 'bar');
    });

    test('empty query', () {
      final records = woozy.search('');
      expect(records.length, 2);
    });

    test('associated value should be `null`', () {
      final records = woozy.search('foo');
      expect(records.length, 2);

      final first_record = records.first;
      expect(first_record.value, null);

      final second_record = records.last;
      expect(second_record.value, null);
    });
  });

  group('Long and short queries', () {
    final woozy = Woozy();

    setUp(() {
      woozy.set_entries(['sun', 'sunflower']);
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
      woozy.add_entries(List.filled(10, 'Foo'));
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
    test('without values', () {
      final woozy = Woozy();

      woozy.add_entry('foo');
      woozy.add_entry('bar');
      final records = woozy.search('f');
      expect(records.first.value, null);
    });

    test('integers', () {
      final woozy = Woozy();

      woozy.add_entry('foo', value: 0);
      woozy.add_entry('bar', value: 1);
      final records = woozy.search('f');
      expect(records.first.value, 0);
    });

    test('UUIDs', () {
      final woozy = Woozy();
      final foo_id = Uuid();
      final bar_id = Uuid();

      woozy.add_entry('foo', value: foo_id);
      woozy.add_entry('bar', value: bar_id);
      final records = woozy.search('f');
      expect(records.first.value, foo_id);
    });
  });
}
