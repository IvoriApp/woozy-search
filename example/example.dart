import 'package:woozy_search/woozy_search.dart';

void woozy_search(woozy, query) {
  final output = woozy.search(query);
  print("Search for: '$query':");
  output.forEach((element) => print(' - ${element}'));
  print('---\n');
}

void basic_usage() {
  final woozy = Woozy();
  woozy.add_entries(['basketball', 'badminton', 'skating']);
  woozy_search(woozy, 'badmi');
}

void with_associated_values() {
  final woozy = Woozy();
  woozy.add_entry('John Doe', value: "+1 210-269-0117");
  woozy.add_entry('Nate Humphrey', value: "+1 (416) 527-4927");
  woozy.add_entry('Serena Waldorf', value: "+ 1 914-514-7901");
  woozy_search(woozy, 'humphray');
}

void with_search_output_limit() {
  final woozy = Woozy(limit: 2);
  woozy.set_entries(List.filled(100, 'foo'));
  woozy_search(woozy, 'f');
}

void with_case_sensitive() {
  final woozy = Woozy(case_sensitive: true);
  woozy.set_entries(['FOO', 'boo']);
  woozy_search(woozy, 'foo');
}

void main() {
  basic_usage();

  with_associated_values();

  with_search_output_limit();

  with_case_sensitive();
}
