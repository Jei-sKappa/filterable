part of 'filter_type.dart';

@Target({TargetKind.field})

/// [CustomFilter]
class CustomFilter implements FilterType {
  /// Use this annotation to assign a custom filter
  /// of type [filter] to a field.
  ///
  /// Example:
  /// ```dart
  /// @CustomFilter('MyCustomFilter')
  /// final String value;
  /// // Will generate:
  /// MyCustomFilter valueFilter
  /// ```
  ///
  /// N.B. If you want to customize the name of the
  /// filter, you can use the [CustomFilter.named]
  const CustomFilter([this.filter]) : name = null;

  /// Use this annotation to assign a custom filter
  /// of type [filter] with name [name] to a field.
  ///
  /// Example:
  /// ```dart
  /// @CustomFilter.named('myVarName', filter:'MyCustomFilter')
  /// final String value;
  /// // Will generate:
  /// MyCustomFilter myVarName
  /// ```
  const CustomFilter.named(this.name, {this.filter});

  /// The type of the filter
  final String? filter;

  /// The variable name for the filter
  @override
  final String? name;
}
