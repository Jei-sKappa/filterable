part of 'filter_mode.dart';

/// An annotation to speicify that a field is filterable
/// by range.
@Target({TargetKind.field})
class RangeFilter implements FilterMode {
  /// Creates a new [RangeFilter] instance.
  ///
  /// Only required when the default behavior is not desired.
  const RangeFilter();
}
