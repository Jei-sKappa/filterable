import 'package:filterable/filterable.dart';

/// A [DateFilterWithoutNullability].
/// This allows to filter strings
class DateFilterWithoutNullability implements ValueFilterable<DateTime> {
  /// Creates a [DateFilterWithoutNullability]
  DateFilterWithoutNullability(this.value);

  /// The query to filter the string
  @override
  DateTime value;

  @override
  bool allowNull = false;

  /// Creates a copy of this DateTimeFilter with the given fields replaced
  DateFilterWithoutNullability copyWith({
    DateTime? value,
  }) =>
      DateFilterWithoutNullability(
        value ?? this.value,
      );
}
