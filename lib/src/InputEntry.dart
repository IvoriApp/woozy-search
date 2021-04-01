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

