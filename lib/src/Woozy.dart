import 'dart:math';

import 'package:woozy_search/src/Levenshtein.dart';
import 'package:collection/collection.dart';

import 'InputEntry.dart';
import 'MatchResult.dart';

/// The main entry point to the library woozy search.
class Woozy<Value> {
  /// Limit the number of items return from search. Default to 10.
  final int limit;

  /// Specify whether the string matching is case sensitive or not. Default
  /// to `false`.
  final bool caseSensitive;

  /// A list of items to be searched.
  List<InputEntry<Value>> _entries = [];

  final Levenshtein _levenshtein = Levenshtein();

  /// Constructor to create a `Woozy` object.
  Woozy({this.limit = 10, this.caseSensitive = false}) {
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
  void addEntry(String text, {Value? value}) {
    _entries.add(
        InputEntry<Value>(text, value: value, caseSensitive: caseSensitive));
  }

  /// Add a list of items to be searched for.
  void addEntries(List<String> texts) {
    _entries.addAll(
        texts.map((e) => InputEntry<Value>(e, caseSensitive: caseSensitive)));
  }

  /// Set the list of items to be searched for. This will overwrite exiting
  /// items.
  void setEntries(List<String> texts) {
    _entries = texts
        .map((e) => InputEntry<Value>(e, caseSensitive: caseSensitive))
        .toList();
  }

  /// The main search function.
  ///
  /// Given a search query. Return a list of search results.
  List<MatchResult<Value>> search(String query) {
    // Use a heap to keep track of the top `limit` best scores
    var heapPQ = HeapPriorityQueue<MatchResult<Value>>(
        (lhs, rhs) => lhs.score.compareTo(rhs.score));

    _entries.forEach((entry) {
      final bestScore = entry.words.fold<double>(0.0, (currentScore, word) {
        final distance = _levenshtein.distance(query, word);
        final maxLength = max(query.length, word.length);
        final score = (maxLength - distance) / maxLength;
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
