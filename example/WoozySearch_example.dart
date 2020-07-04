import 'package:WoozySearch/WoozySearch.dart';

void woozy_search(woozy, query) {
  final output = woozy.search(query);
  print("Search for: '$query':");
  output.forEach((element) {
    print(' - ${element}');
  });
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

void main() {
  basic_usage();

  with_associated_values();
}

