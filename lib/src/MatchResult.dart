/// The output search result.
class MatchResult<Value> {
  /// The [score] of the match result represent how goo the match is.
  ///
  /// Minimum is 0 and maximum is 1.
  final double score;

  /// The [text] that is being searched on.
  final String text;

  /// The optional associated [value] of [text].
  final Value? value;

  /// Constructor.
  MatchResult(this.score, {required this.text, required this.value});

  /// For print formatting.
  @override
  String toString() {
    final textAndScore = 'text: $text, score: ${score.toStringAsFixed(2)}';
    if (value != null) {
      return '$textAndScore, value: $value';
    } else {
      return textAndScore;
    }
  }
}
