import 'package:filterable/src/base_type_filterable.dart';

/// A [IntFilter].
/// This allows to filter strings
class IntFilter extends TypeFilterable<int> {
  /// Creates a IntFilter
  IntFilter(this.value);

  /// The query to filter the string
  @override
  int value;

  /// Creates a copy of this IntFilter with the given fields replaced
  IntFilter copyWith(int? value) => IntFilter(value ?? this.value);
}
