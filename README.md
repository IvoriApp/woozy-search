# Woozy Search

A super simple and lightweight client-side fuzzy-search library based on Levenshtein distance. 

## Usage

```pubspec.yaml
dependencies:
  woozy_search: '>=1.0.1 <2.0.0'
```

**Basic Usage**

```dart
import 'package:WoozySearch/woozy_search.dart';

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

**With Associate Values**

Associate value can be anything, integers, UUIDs, text, etc. 
As an example, we use a name and their phone number here. 

```dart
import 'package:WoozySearch/woozy_search.dart';

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

**With Search Output Limit**

Limit the number of search result to return.
It is defaulted to 10, but can be overwritten. 

```dart
import 'package:WoozySearch/woozy_search.dart';
  
main() {
  final woozy = Woozy(limit: 2);
  woozy.set_entries(List.filled(100, 'foo'));
  final output = woozy.search('f');
  output.forEach((element) => print(' - ${element}'));
}
```

Output:

```text
 - text: foo, score: 0.33
 - text: foo, score: 0.33
```

**With Case Sensitive**

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
