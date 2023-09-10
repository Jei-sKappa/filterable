import 'package:filterable/src/base_type_filterable.dart';

/// A [DateTimeRangeFilter]
/// that allows to filter projects by date
class DateTimeRangeFilter extends TypeRangeFilterable<DateTime> {
  /// Creates a DateFilter
  DateTimeRangeFilter({
    this.min,
    this.max,
  });

  /// The minimum date to filter projects
  @override
  DateTime? min;

  /// The maximum date to filter projects
  @override
  DateTime? max;

  /// Creates a copy of DateFilter
  DateTimeRangeFilter copyWith({
    DateTime? Function()? min,
    DateTime? Function()? max,
  }) {
    return DateTimeRangeFilter(
      min: min != null ? min() : this.min,
      max: max != null ? max() : this.max,
    );
  }
}
