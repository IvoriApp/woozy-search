import 'package:WoozySearch/WoozySearch.dart';

void woozy_search(woozy, query) {
  var output = woozy.search(query);
  print("Search for: '$query':");
  output.forEach((element) {
    print(' - ${element}');
  });
  print('---\n');
}

void example3() {
  var woozy = Woozy();
  woozy.add_entries(['sun', 'sunflowers']);
  woozy_search(woozy, 'su');
}

void main() {
  example3();
}
