import 'package:meta/meta.dart';

class InputEntry<T> {
  final String text;
  final T value;

  List<String> _words;

  List<String> get words => _words;

  InputEntry(this.text, {this.value}) {
    _words = text.split(' ');
  }
}

class MatchResult<T> {
  final double score;
  final String text;
  final T value;

  MatchResult(this.score, {@required this.text, @required this.value});

  @override
  String toString() {
    return 'key: ${text}, score: ${score}';
  }
}
