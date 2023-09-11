part of 'filter_type.dart';

/// An annotation to speicify that a field is filterable
/// by value.
@Target({TargetKind.field})
class ValueFilter implements FilterType {
  /// Creates a new [ValueFilter] instance.
  ///
  /// Only required when the default behavior is not desired.
  const ValueFilter({
    this.defaultValue,
    this.includeDefaultsInConstructor = true,
  });

  /// The default value for the field.
  final String? defaultValue;

  /// Whether the field should be included in the generated constructor.
  final bool includeDefaultsInConstructor;
}
