part of 'filter_mode.dart';

/// An annotation to speicify that a field is filterable
/// by value.
@Target({TargetKind.field})
class ValueFilter implements FilterMode {
  /// Creates a new [ValueFilter] instance.
  ///
  /// Only required when the default behavior is not desired.
  const ValueFilter();
}
