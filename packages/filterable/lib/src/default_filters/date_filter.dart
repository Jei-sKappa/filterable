import 'package:filterable/src/base_type_filterable.dart';

/// A [DateTimeFilter].
/// This allows to filter strings
class DateTimeFilter extends TypeFilterable<DateTime> {
  /// Creates a DateTimeFilter
  DateTimeFilter(this.value);

  /// The query to filter the string
  @override
  DateTime value;

  /// Creates a copy of this DateTimeFilter with the given fields replaced
  DateTimeFilter copyWith(DateTime? value) =>
      DateTimeFilter(value ?? this.value);
}
