import 'package:filterable/src/value_filterable.dart';

/// A [IntFilter].
/// This allows to filter strings
class IntFilter implements ValueFilterable<int?> {
  /// Creates a IntFilter
  IntFilter(
    this.value, {
    this.allowNull = false,
  });

  /// The query to filter the string
  @override
  int? value;

  @override
  bool allowNull;

  /// Creates a copy of this IntFilter with the given fields replaced
  IntFilter copyWith({
    int? Function()? value,
    bool? allowNull,
  }) =>
      IntFilter(
        value != null ? value() : this.value,
        allowNull: allowNull ?? this.allowNull,
      );
}
