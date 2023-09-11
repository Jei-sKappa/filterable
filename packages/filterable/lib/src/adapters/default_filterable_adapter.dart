import 'package:filterable/src/adapters/filterable_adapter.dart';
import 'package:filterable/src/adapters/filterable_type_adapter.dart';
import 'package:filterable/src/filterable.dart';
import 'package:filterable/src/type_filterables/default_type_filterables/default_type_filterables.dart';
import 'package:filterable/src/type_filterables/type_filterable.dart';

/// A Filterable Adapter that requires all the adapters
/// for the default filter types
class DefaultFilterableAdapter<R> extends FilterableAdapter<R> {
  /// Creates a new FilterableAdapter
  DefaultFilterableAdapter({
    required this.dateFilterAdapter,
    required this.dateRangeFilterAdapter,
    required this.intFilterAdapter,
    required this.intRangeFilterAdapter,
    required this.stringFilterAdapter,
    this.customAdapters,
  });

  // DateTime
  FilterableTypeAdapter<R, DateTimeFilter> dateFilterAdapter;
  FilterableTypeAdapter<R, DateTimeRangeFilter> dateRangeFilterAdapter;

  // Int
  FilterableTypeAdapter<R, IntFilter> intFilterAdapter;
  FilterableTypeAdapter<R, IntRangeFilter> intRangeFilterAdapter;

  // String
  FilterableTypeAdapter<R, StringFilter> stringFilterAdapter;

  // Custom Types
  List<FilterableTypeAdapter<R, BaseTypeFilterable>>? customAdapters;

  /// TODO: Missing principal docs
  ///
  /// If a filter is not implemented, it will throw an [UnimplementedError]
  @override
  R getFilteredData(
    R data,
    Filterable filterable, {
    required bool descending,
  }) {
    var query = data;

    for (final filterableField in filterable.filters) {
      // TODO: This isn't a value checking switch: if we forget to add a new
      // filterable type, it will throw an error in runtime
      switch (filterableField.typeFilterable) {
        case final DateTimeFilter dateTimeFilter:
          query = dateFilterAdapter.getFilteredData(
            query,
            filterableField.fieldId,
            dateTimeFilter,
            descending: descending,
          );

        case final DateTimeRangeFilter dateTimeRangeFilter:
          query = dateRangeFilterAdapter.getFilteredData(
            query,
            filterableField.fieldId,
            dateTimeRangeFilter,
            descending: descending,
          );

        case final IntFilter intFilter:
          query = intFilterAdapter.getFilteredData(
            query,
            filterableField.fieldId,
            intFilter,
            descending: descending,
          );

        case final IntRangeFilter intRangeFilter:
          query = intRangeFilterAdapter.getFilteredData(
            query,
            filterableField.fieldId,
            intRangeFilter,
            descending: descending,
          );

        case final StringFilter stringFilter:
          query = stringFilterAdapter.getFilteredData(
            query,
            filterableField.fieldId,
            stringFilter,
            descending: descending,
          );

        default:
          var findedFilterAdapter = false;
          if (customAdapters != null) {
            for (final adapter in customAdapters!) {
              if (adapter.adapterOfFilter ==
                  filterableField.typeFilterable.runtimeType) {
                query = adapter.getFilteredData(
                  query,
                  filterableField.fieldId,
                  filterableField.typeFilterable,
                  descending: descending,
                );
                findedFilterAdapter = true;
                break;
              }
            }
          }

          if (!findedFilterAdapter) {
            // TODO: Throw specific error
            throw Exception(
              // ignore: lines_longer_than_80_chars
              'Not founded adapter for${filterableField.typeFilterable.runtimeType}',
            );
          }
      }
    }

    return query;
  }
}
