part of 'filter_type.dart';

/// An annotation to speicify that a field is filterable
/// by range.
@Target({TargetKind.field})
class RangeFilter implements FilterType {
  /// Creates a new [RangeFilter] instance.
  ///
  /// Only required when the default behavior is not desired.
  const RangeFilter([this.name]);

  @override
  final String? name;
}
