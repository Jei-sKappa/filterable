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
class StringFilter extends TypeFilterable<String?> {
  /// Creates a StringFilter
  StringFilter(
    this.value, {
    this.allowNull = false,
    StringFilterMode? mode,
    bool? matchWithLowercase,
    bool? enableTrim,
  })  : mode = mode ?? StringFilterMode.startsWith,
        matchWithLowercase = matchWithLowercase ?? true,
        enableTrim = enableTrim ?? true;

  /// The query to filter the string
  @override
  String? value;

  @override
  bool allowNull;

  /// The mode to filter the string
  StringFilterMode mode;

  /// If true, the query will be matched with lowercase
  bool matchWithLowercase;

  /// If true, the query will be trimmed
  bool enableTrim;

  /// Creates a copy of this StringFilter with the given fields replaced
  StringFilter copyWith({
    String? value,
    bool? allowNull,
    StringFilterMode? mode,
    bool? matchWithLowercase,
    bool? enableTrim,
  }) =>
      StringFilter(
        value ?? this.value,
        allowNull: allowNull ?? this.allowNull,
        mode: mode ?? this.mode,
        matchWithLowercase: matchWithLowercase ?? this.matchWithLowercase,
        enableTrim: enableTrim ?? this.enableTrim,
      );
}
