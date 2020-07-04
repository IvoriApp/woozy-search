import 'dart:math';

import 'package:WoozySearch/src/Levenshtein.dart';
import 'package:collection/collection.dart';

import 'Models.dart';

class Woozy<T> {
  final int limit;
  List<InputEntry<T>> fixedLengthList = [];

  final Levenshtein _levenshtein = Levenshtein();

  /// @param limit: limit the number of items return from search, default to return 10 items.
  Woozy({this.limit = 10}) {
    assert(limit > 0, 'limit need to be greater than zero');
  }

  void add_entry(String text, {T value}) {
    fixedLengthList.add(InputEntry(text, value: value));
  }

  void add_entries(List<String> texts) {
    fixedLengthList.addAll(texts.map((e) => InputEntry(e)));
  }

  void set_entries(List<String> texts) {
    fixedLengthList = texts.map((e) => InputEntry(e)).toList();
  }

  List<MatchResult> search(String query) {
    // Use a heap to keep track of the top `limit` best scores
    var heapPQ = HeapPriorityQueue<MatchResult>(
        (lhs, rhs) => lhs.score.compareTo(rhs.score));

    fixedLengthList.forEach((entry) {
      final bestScore = entry.words.fold(0.0, (currentScore, word) {
        final distance = _levenshtein.distance(query, word);
        final max_length = max(query.length, word.length);
        final score = (max_length - distance) / max_length;
        return max<double>(currentScore, score);
      });

      heapPQ.add(MatchResult(bestScore, text: entry.text, value: entry.value));

      if (heapPQ.length > limit) {
        heapPQ.removeFirst();
      }
    });

    final result = heapPQ.toList();
    result.sort((a, b) => b.score.compareTo(a.score));
    return result;
  }
}
