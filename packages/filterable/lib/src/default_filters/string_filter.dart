import 'package:filterable/src/base_type_filterable.dart';

/// String filter mode
enum StringFilterMode {
  /// Uses the contains method
  contains,

  /// Uses the startsWith method
  startsWith,

  /// Uses the endsWith method
  endsWith,
}

/// A [StringFilter].
/// This allows to filter strings
class StringFilter extends TypeFilterable<String>{
  /// Creates a StringFilter
  StringFilter({
    String? query,
    StringFilterMode? mode,
    bool? matchWithLowercase,
    bool? enableTrim,
  })  : value = query ?? '',
        mode = mode ?? StringFilterMode.startsWith,
        matchWithLowercase = matchWithLowercase ?? true,
        enableTrim = enableTrim ?? true;

  /// The query to filter the string
  @override
  String value;

  /// The mode to filter the string
  StringFilterMode mode;

  /// If true, the query will be matched with lowercase
  bool matchWithLowercase;

  /// If true, the query will be trimmed
  bool enableTrim;

  /// Creates a copy of this StringFilter with the given fields replaced
  StringFilter copyWith({
    String? query,
    StringFilterMode? mode,
    bool? matchWithLowercase,
    bool? enableTrim,
  }) =>
      StringFilter(
        query: query ?? value,
        mode: mode ?? this.mode,
        matchWithLowercase: matchWithLowercase ?? this.matchWithLowercase,
        enableTrim: enableTrim ?? this.enableTrim,
      );
}
