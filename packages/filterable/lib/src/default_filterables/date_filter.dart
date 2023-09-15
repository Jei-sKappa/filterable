import 'package:filterable/src/value_filterable.dart';

/// A [DateTimeFilter].
/// This allows to filter strings
class DateTimeFilter implements ValueFilterable<DateTime?> {
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
    DateTime? Function()? value,
    bool? allowNull,
  }) =>
      DateTimeFilter(
        value != null ? value() : this.value,
        allowNull: allowNull ?? this.allowNull,
      );
}
