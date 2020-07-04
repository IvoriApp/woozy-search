import 'package:meta/meta.dart';

class InputEntry<T> {
  final String text;

  /// Optional associate value
  final T value;

  List<String> _words;

  List<String> get words => _words;

  InputEntry(this.text, {this.value, @required bool case_sensitive}) {
    _words = text.split(' ');
    if (!case_sensitive) {
      _words = _words.map((word) => word.toLowerCase()).toList();
    }
  }
}

class MatchResult<T> {
  final double score;
  final String text;
  final T value;

  MatchResult(this.score, {@required this.text, @required this.value});

  @override
  String toString() {
    final textAndScore = 'text: ${text}, score: ${score.toStringAsFixed(2)}';
    if (value != null) {
      return '$textAndScore, value: $value';
    } else {
      return textAndScore;
    }
  }
}
