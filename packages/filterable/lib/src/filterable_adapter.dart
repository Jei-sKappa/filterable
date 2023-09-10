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
          // query = _getStringFilteredCollection(
          //   query,
          //   filter.jsonKey,
          //   filter as StringFilter,
          //   descending: descending,
          // );
          final stringFilter = filter.typeFilterable as StringFilter;
          if (stringFilter.value.isNotEmpty) {
            query = stringFilterAdapter.getFilteredData(
              query,
              filter.fieldId,
              stringFilter,
              descending: descending,
            );
          }

        case DateTimeRangeFilter:
          // query = _getDateRangeFilteredCollection(
          //   query,
          //   filter.jsonKey,
          //   filter as DateRangeFilter,
          //   descending: descending,
          // );
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
            print("Not founded adapter for ${filter.typeFilterable.runtimeType}");
            // TODO: Throw specific error
            throw UnimplementedError();
          }
      }
    }

    // // Name Filter
    // if (filter.nameFilter.value.isNotEmpty) {
    //   query = _getStringFilteredCollection(
    //     query,
    //     ProjectField.name.jsonKey,
    //     filter.nameFilter,
    //     descending: descending,
    //   );
    // }

    // // Client Filter
    // if (filter.clientNameFilter.value.isNotEmpty) {
    //   query = _getStringFilteredCollection(
    //     query,
    //     ProjectField.clientName.jsonKey,
    //     filter.clientNameFilter,
    //     descending: descending,
    //   );
    // }

    // // Creation Date Filter
    // query = _getDateRangeFilteredCollection(
    //   query,
    //   ProjectField.creationTime.jsonKey,
    //   filter.creationDateRange,
    //   descending: descending,
    // );

    // // Project Status Filter
    // switch (filter.statusFilter.value) {
    //   case null:
    //     // Showing all: no filter
    //     break;
    //   // ignore: no_default_cases
    //   default:
    //     query = _getStatusFilteredCollection(
    //       query,
    //       filter.statusFilter.value!,
    //     );
    // }

    return query;
  }
}
