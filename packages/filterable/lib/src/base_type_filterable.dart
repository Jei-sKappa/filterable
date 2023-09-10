/// Base class for all filters.
sealed class BaseTypeFilterable {
  // / The type of the filter
  // Type filterOfType = T;
}

/// Base class for all filters.
abstract class TypeFilterable<T> extends BaseTypeFilterable {
  /// Value of the filter
  abstract T value;
}

/// Base class for all range filters.
abstract class TypeRangeFilterable<T> extends BaseTypeFilterable {
  /// Minimum value of the range filter
  abstract T? min;

  /// Maximum value of the range filter
  abstract T? max;
}
