import 'package:filterable/src/range_filterable.dart';

/// A [IntRangeFilter]
/// that allows to filter projects by date
class IntRangeFilter implements RangeFilterable<int> {
  /// Creates a intFilter
  IntRangeFilter(
    this.min,
    this.max,
  );

  /// The minimum date to filter projects
  @override
  int? min;

  /// The maximum date to filter projects
  @override
  int? max;

  /// Creates a copy of intFilter
  IntRangeFilter copyWith({
    int? Function()? min,
    int? Function()? max,
  }) {
    return IntRangeFilter(
      min != null ? min() : this.min,
      max != null ? max() : this.max,
    );
  }
}
