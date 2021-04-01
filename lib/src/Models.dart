/// Data class for holding a single input searchable item.
class InputEntry<Value> {
  /// The original search [text].
  final String text;

  /// Optional associate value to the [text] that will be searched on.
  final Value? value;

  /// A list of words that is tokenized from [text].
  late List<String> _words;

  /// Reach only list of [words].
  List<String> get words => _words;

  /// Constructor of a input entry.
  InputEntry(this.text, {this.value, required bool caseSensitive}) {
    _words = text.split(' ');
    if (!caseSensitive) {
      _words = _words.map((word) => word.toLowerCase()).toList();
    }
  }
}

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
