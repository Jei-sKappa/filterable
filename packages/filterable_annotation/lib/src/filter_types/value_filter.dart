part of 'filter_type.dart';

/// An annotation to speicify that a field is filterable
/// by value.
@Target({TargetKind.field})
class ValueFilter implements FilterType {
  /// Creates a new [ValueFilter] instance.
  ///
  /// Only required when the default behavior is not desired.
  const ValueFilter([this.name]);

  @override
  final String? name;
}
