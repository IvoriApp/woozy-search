# Woozy Search

A super simple and lightweight client-side fuzzy-search library based on levenshtein distance. 

## Usage

**Basic usage**

```dart
import 'package:WoozySearch/WoozySearch.dart';

main() {
  final woozy = Woozy();
  woozy.add_entries(['basketball', 'badminton', 'skating']);
  final output = woozy.search('badmi');
  output.forEach((element) => print(' - ${element}'));
}
```

Output:

```text
 - text: badminton, score: 0.56
 - text: basketball, score: 0.20
 - text: skating, score: 0.14
```

**With associate values**

```dart
import 'package:WoozySearch/WoozySearch.dart';

main() {
  final woozy = new Woozy();
  woozy.add_entry('John Doe', value: "+1 210-269-0117");
  woozy.add_entry('Nate Humphrey', value: "+1 (416) 527-4927");
  woozy.add_entry('Serena Waldorf', value: "+ 1 914-514-7901");
  final output = woozy.search('humphray');
  output.forEach((element) => print(' - ${element}'));
}
```

Output:

```text
 - text: Nate Humphrey, score: 0.88, value: +1 (416) 527-4927
 - text: Serena Waldorf, score: 0.13, value: + 1 914-514-7901
 - text: John Doe, score: 0.13, value: +1 210-269-0117
```

**With search output limit**

```dart
import 'package:WoozySearch/WoozySearch.dart';
  
main() {
  final woozy = Woozy(limit: 2);
  woozy.set_entries(List.filled(10, 'foo'));
  final output = woozy.search('f');
  output.forEach((element) => print(' - ${element}'));
}
```

Output:

```text
 - text: foo, score: 0.33
 - text: foo, score: 0.33
```

**With case sensitive**

```dart
main() {
  final woozy = Woozy(case_sensitive: true);
  woozy.set_entries(['FOO', 'boo']);
  final output = woozy.search('foo');
  output.forEach((element) => print(' - ${element}'));
}
```

Output:

```text
 - text: boo, score: 0.67
 - text: FOO, score: 0.00
```

## Features and bugs

Please file feature requests and bugs at the [issue tracker][tracker].

[tracker]: https://github.com/IvoriApp/woozy-search/issues
