import 'package:filterable/src/type_filterables/type_filterable.dart';

/// A [DateTimeFilter].
/// This allows to filter strings
class DateTimeFilter extends TypeFilterable<DateTime?> {
  /// Creates a DateTimeFilter
  DateTimeFilter(
    this.value, {
    this.allowNull = false,
  });

  /// The query to filter the string
  @override
  DateTime? value;

  @override
  bool allowNull;

  /// Creates a copy of this DateTimeFilter with the given fields replaced
  DateTimeFilter copyWith({
    DateTime? value,
    bool? allowNull,
  }) =>
      DateTimeFilter(
        value ?? this.value,
        allowNull: allowNull ?? this.allowNull,
      );
}
