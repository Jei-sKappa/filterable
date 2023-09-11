import 'package:filterable/src/type_filterables/type_filterable.dart';
import 'package:meta/meta.dart';

/// Interface for a FilterableTypeAdapter
abstract class FilterableTypeAdapter<R, F extends BaseTypeFilterable> {
  /// The type of the filter
  @nonVirtual
  Type adapterOfFilter = F;

  /// Returns the filtered Data
  R getFilteredData(
    R data,
    String fieldId,
    F filter, {
    required bool descending,
  });
}
