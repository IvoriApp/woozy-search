import 'package:woozy_search/src/Levenshtein.dart';
import 'package:test/test.dart';

void main() {
  Levenshtein levenshtein;
  setUp(() {
    levenshtein = Levenshtein();
  });
  group('Levenshtein Distance', () {
    test('Empty strings', () {
      expect(levenshtein.distance('', ''), 0);
    });

    test('Single char distance is 1 with one insertion or addition', () {
      expect(levenshtein.distance('x', ''), 1);
    });

    test('Single char distance is 1 with one replacement', () {
      expect(levenshtein.distance('x', 'y'), 1);
    });

    test("Partial match: 'HYUNDAI' vs 'HONDA'", () {
      // H Y U N D A I
      // H - O N D A -
      // V X X V V V X
      expect(levenshtein.distance('HONDA', 'HYUNDAI'), 3);
    });

    test("Completely not match: 'Apple' vs 'Banana'", () {
      expect(levenshtein.distance('Apple', 'Banana'), 6);
    });

    test('Instance reuse when dp array changes size', () {
      expect(levenshtein.distance('t', 'a-long-string'), 12);
      expect(
        () => levenshtein.distance('to', 'short'),
        isNot(throwsRangeError),
      );
      expect(levenshtein.distance('to', 'short'), 4);
    });
  });
}
