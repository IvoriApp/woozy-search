import 'package:woozy_search/woozy_search.dart';

void woozySearch(woozy, query) {
  final output = woozy.search(query);
  print("Search for: '$query':");
  output.forEach((element) => print(' - $element'));
  print('---\n');
}

void basicUsage() {
  final woozy = Woozy();
  woozy.addEntries(['basketball', 'badminton', 'skating']);
  woozySearch(woozy, 'badmi');
}

void withAssociatedValues() {
  final woozy = Woozy();
  woozy.addEntry('John Doe', value: '+1 210-269-0117');
  woozy.addEntry('Nate Humphrey', value: '+1 (416) 527-4927');
  woozy.addEntry('Serena Waldorf', value: '+ 1 914-514-7901');
  woozySearch(woozy, 'humphray');
}

void withSearchOutputLimit() {
  final woozy = Woozy(limit: 2);
  woozy.setEntries(List.filled(100, 'foo'));
  woozySearch(woozy, 'f');
}

void withCaseSensitive() {
  final woozy = Woozy(caseSensitive: true);
  woozy.setEntries(['FOO', 'boo']);
  woozySearch(woozy, 'foo');
}

void main() {
  basicUsage();

  withAssociatedValues();

  withSearchOutputLimit();

  withCaseSensitive();
}
