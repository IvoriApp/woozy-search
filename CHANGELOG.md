## 2.0.3

- Models.dart separated into InputEntry.dart and MatchResult.dart
- woozy_search.dart exports src/MatchResult.dart

## 2.0.1

- Migrate to null-safety, use newer dart features (`late` and `required`) and make code more Dart-like
- Change the name of the generic `T` for a more descriptive `Value`

## 2.0.0

- Convert from snake-case to lowerCamelCase [PR](https://github.com/IvoriApp/woozy-search/pull/5)
- Fix RangeError exception when reusing instance of `woozy` [PR](https://github.com/IvoriApp/woozy-search/pull/4)
- Add type to `MatchResult` [PR](https://github.com/IvoriApp/woozy-search/pull/2)

## 1.0.2

- Add comment documentations
- Provide `example.dart` file 

## 1.0.1

- Relax dependency on collection versions

## 1.0.0

- Initial version, supporting fuzzy search with Levenshtein distance
