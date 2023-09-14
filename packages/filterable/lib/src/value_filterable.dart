import 'package:filterable/src/base_filterable.dart';

/// Base class for all filters.
abstract interface class ValueFilterable<T> implements BaseFilterable {
  /// If true, the filter can be null
  abstract bool allowNull;

  /// Value of the filter
  abstract T value;
}
