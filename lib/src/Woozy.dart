import 'dart:math';

import 'package:woozy_search/src/Levenshtein.dart';
import 'package:collection/collection.dart';

import 'Models.dart';

/// The main entry point to the library woozy search.
class Woozy<T> {
  /// Limit the number of items return from search. Default to 10.
  final int limit;

  /// Specify whether the string matching is case sensitive or not. Default
  /// to `false`.
  final bool case_sensitive;

  /// A list of items to be searched.
  List<InputEntry<T>> _entries = [];

  final Levenshtein _levenshtein = Levenshtein();

  /// Constructor to create a `Woozy` object.
  Woozy({this.limit = 10, this.case_sensitive = false}) {
    assert(limit > 0, 'limit need to be greater than zero');
  }

  /// Add a new entry to the list of items to be searched for.
  ///
  /// [text] is where the search will be based on.
  ///
  /// [value] is an optional value that can be attached the [text].
  ///
  /// Example 1, [text] can be a description of an article, and [value] can be
  /// a database id pointing to the entire article.
  /// Example 2, [text] can be a label of an image, and [value] can the filename
  /// of the image.
  void add_entry(String text, {T value}) {
    _entries
        .add(InputEntry(text, value: value, case_sensitive: case_sensitive));
  }

  /// Add a list of items to be searched for.
  void add_entries(List<String> texts) {
    _entries.addAll(
        texts.map((e) => InputEntry(e, case_sensitive: case_sensitive)));
  }

  /// Set the list of items to be searched for. This will overwrite exiting
  /// items.
  void set_entries(List<String> texts) {
    _entries = texts
        .map((e) => InputEntry(e, case_sensitive: case_sensitive))
        .toList();
  }

  /// The main search function.
  ///
  /// Given a search query. Return a list of search results.
  List<MatchResult<T>> search(String query) {
    // Use a heap to keep track of the top `limit` best scores
    var heapPQ = HeapPriorityQueue<MatchResult<T>>(
        (lhs, rhs) => lhs.score.compareTo(rhs.score));

    _entries.forEach((entry) {
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
