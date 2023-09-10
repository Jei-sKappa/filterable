import 'package:filterable/src/base_type_filterable.dart';

/// A [DateRangeFilter]
/// that allows to filter projects by date
class DateRangeFilter extends TypeRangeFilterable<DateTime> {
  /// Creates a DateFilter
  DateRangeFilter({
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
  DateRangeFilter copyWith({
    DateTime? Function()? min,
    DateTime? Function()? max,
  }) {
    return DateRangeFilter(
      min: min != null ? min() : this.min,
      max: max != null ? max() : this.max,
    );
  }
}
