import 'package:filterable/src/base_filterable.dart';
import 'package:filterable/src/filter_adapter.dart';
import 'package:meta/meta.dart';

/// {@template filterable}
/// A Dart package that helps to implement filtering
/// {@endtemplate}
abstract class Filterable implements BaseFilterable {
  /// The list of filters
  List<FilterableField> get filters;

  /// {@template filterFrom}
  /// An helper function that helps to implement filtering.
  ///
  /// [R] is the type of the data you want in response
  /// after filtering.
  /// {@endtemplate}
  static R filterFrom<R>(
    Filterable filterable, {
    required R data,
    required List<String> fieldPath,
    bool descending = false,
    List<FilterAdapter<R, BaseFilterable>> adapters = const [],
  }) {
    var newData = data;

    for (final filterableField in filterable.filters) {
      // A the current filter is a [Filterable]
      // we need to recursively call the [filter]
      // method with the current [Filterable].
      // Otherwise, we need to find the correct adapter
      // and call the [getFilteredData] method.
      if (filterableField.typeFilterable is Filterable) {
        final filterable = filterableField.typeFilterable as Filterable;
        newData = filterable.filter(
          newData,
          // Must append the current fieldId to the fieldPath
          fieldPath: [...fieldPath, filterableField.fieldId],
          adapters: adapters,
          descending: descending,
        );
      } else {
        var findedFilterAdapter = false;
        for (final adapter in adapters) {
          if (adapter.adapterOfFilter ==
              filterableField.typeFilterable.runtimeType) {
            newData = adapter.getFilteredData(
              newData,
              filterableField.typeFilterable,
              // Must append the current fieldId to the fieldPath
              fieldPath: [...fieldPath, filterableField.fieldId],
              descending: descending,
            );
            findedFilterAdapter = true;
            break;
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

    return newData;
  }

  /// {@macro filterFrom}
  @nonVirtual
  R filter<R>(
    R data, {
    required List<String> fieldPath,
    bool descending = false,
    List<FilterAdapter<R, BaseFilterable>> adapters = const [],
  }) =>
      filterFrom(
        this,
        data: data,
        fieldPath: fieldPath,
        descending: descending,
        adapters: adapters,
      );
}

/// {@template filterableField}
/// TODO: Missing docs
/// {@endtemplate}
class FilterableField {
  /// {@macro filterableField}
  const FilterableField({
    required this.fieldId,
    required this.typeFilterable,
  });

  /// An unique identifier for the field
  final String fieldId;

  /// The type of the filter
  final BaseFilterable typeFilterable;
}
