import 'package:filterable/src/base_filterable.dart';

/// Base class for all range filters.
abstract interface class RangeFilterable<T> implements BaseFilterable {
  /// Minimum value of the range filter
  T? min;

  /// Maximum value of the range filter
  T? max;
}