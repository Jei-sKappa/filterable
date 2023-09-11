import 'package:filterable/src/base_type_filterable.dart';
import 'package:filterable/src/default_filters/default_filters.dart';
import 'package:filterable/src/filterable.dart';
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

class FilterableAdapter<R> {
  /// Creates a new FilterableAdapter
  FilterableAdapter({
    required this.stringFilterAdapter,
    required this.dateRangeFilterAdapter,
    this.customAdapters,
  });

  FilterableTypeAdapter<R, StringFilter> stringFilterAdapter;
  FilterableTypeAdapter<R, DateTimeRangeFilter> dateRangeFilterAdapter;
  List<FilterableTypeAdapter<R, BaseTypeFilterable>>? customAdapters;

  /// TODO: Missing principal docs
  ///
  /// If a filter is not implemented, it will throw an [UnimplementedError]
  R getFilteredData(
    R data,
    Filterable filterable, {
    required bool descending,
  }) {
    var query = data;

    for (final filter in filterable.filters) {
      switch (filter.typeFilterable.runtimeType) {
        case StringFilter:
          final stringFilter = filter.typeFilterable as StringFilter;

          // CanFilter based on:
          // 1. allowNull: true - "MyQuery" => canFilter: true
          // 2. allowNull: true - "" => canFilter: false
          // 3. allowNull: true - null => canFilter: true
          // 4. allowNull: false - "MyQuery" => canFilter: true
          // 5. allowNull: false - "" => canFilter: false
          // 6. allowNull: false - null => canFilter: false
          // Result:
          // if value is empty cannot filter
          // if value is not empty can filter
          // if value is null and allowNull is true can filter
          // if value is null and allowNull is false cannot filter
          final canFilter = stringFilter.allowNull
              ? (stringFilter.value?.isNotEmpty ?? true)
              : (stringFilter.value?.isNotEmpty ?? false);
          if (canFilter) {
            query = stringFilterAdapter.getFilteredData(
              query,
              filter.fieldId,
              stringFilter,
              descending: descending,
            );
          }

        case DateTimeRangeFilter:
          query = dateRangeFilterAdapter.getFilteredData(
            query,
            filter.fieldId,
            filter.typeFilterable as DateTimeRangeFilter,
            descending: descending,
          );
        default:
          var finded = false;

          if (customAdapters != null) {
            for (final adapter in customAdapters!) {
              if (adapter.adapterOfFilter ==
                  filter.typeFilterable.runtimeType) {
                query = adapter.getFilteredData(
                  query,
                  filter.fieldId,
                  filter.typeFilterable,
                  descending: descending,
                );
                finded = true;
                break;
              }
            }
          }

          if (finded == false) {
            print(
              'Not founded adapter for ${filter.typeFilterable.runtimeType}',
            );
            // TODO: Throw specific error
            throw UnimplementedError();
          }
      }
    }

    return query;
  }
}
