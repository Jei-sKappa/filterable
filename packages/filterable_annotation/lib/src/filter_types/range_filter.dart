part of 'filter_type.dart';

/// An annotation to speicify that a field is filterable
/// by range.
@Target({TargetKind.field})
class RangeFilter implements FilterType {
  /// Creates a new [RangeFilter] instance.
  ///
  /// Only required when the default behavior is not desired.
  const RangeFilter({
    this.defaultMin,
    this.defaultMax,
    this.includeDefaultsInConstructor = true,
  });

  /// The default value for the minimum value of the range.
  final String? defaultMin;

  /// The default value for the maximum value of the range.
  final String? defaultMax;

  /// Whether the field should be included in the generated constructor.
  final bool includeDefaultsInConstructor;
}
