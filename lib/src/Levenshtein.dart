import 'dart:math';

/// For calculating the `Levenshtein` distance between two words.
/// The Levenshtein distance between two words is the minimum number of
/// single-character edits (insertions, deletions, or substitutions) required
/// to change one word into the other.
class Levenshtein {
  int length1;
  int length2;
  List<List<int>> _dp;

  /// Constructor.
  Levenshtein() {
    length1 = 10;
    length2 = 10;
    _resizeDPArray(length1, length2);
  }

  /// Resize the dynamic programming array to make sure it is big enough for
  /// our need.
  void _resizeDPArray(int length1, int length2) {
    if (this.length1 > length1 && this.length2 > length2) {
      // The array is big enough already, return right away
      return;
    }

    length1 = max(this.length1, length1);
    length2 = max(this.length2, length2);

    _dp = List.generate(
        length1 + 1, (i) => List.filled(length2 + 1, 0, growable: false),
        growable: false);

    // Initial condition for the dynamic programming, if word1 is empty and
    // and word2's length is `k`, then the result is `k` deletion from word2 to
    // get to word1.
    for (var k = 0; k < length1 + 1; k++) {
      _dp[k][0] = k;
    }
    for (var k = 0; k < length2 + 1; k++) {
      _dp[0][k] = k;
    }

    this.length1 = length1;
    this.length2 = length2;
  }

  /// Give two words [word1] and [word2], return their Levenshtein distance.
  int distance(String word1, String word2) {
    _resizeDPArray(word1.length, word2.length);

    for (var i = 0; i < word1.length; i++) {
      for (var j = 0; j < word2.length; j++) {
        _dp[i + 1][j + 1] = min(_dp[i][j + 1], _dp[i + 1][j]) + 1;
        if (word1[i] == word2[j]) {
          _dp[i + 1][j + 1] = min(_dp[i][j], _dp[i + 1][j + 1]);
        } else {
          _dp[i + 1][j + 1] = min(_dp[i][j] + 1, _dp[i + 1][j + 1]);
        }
      }
    }

    return _dp[word1.length][word2.length];
  }
}
