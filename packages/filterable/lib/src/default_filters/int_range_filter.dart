import 'package:filterable/src/base_type_filterable.dart';

/// A [IntRangeFilter]
/// that allows to filter projects by date
class IntRangeFilter extends TypeRangeFilterable<int> {
  /// Creates a intFilter
  IntRangeFilter({
    this.min,
    this.max,
  });

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
      min: min != null ? min() : this.min,
      max: max != null ? max() : this.max,
    );
  }
}
