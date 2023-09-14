import 'package:filterable/src/base_filterable.dart';
import 'package:filterable/src/default_filterables/default_filterables.dart';
import 'package:meta/meta.dart';

/// {@template filter_adapter}
/// An adapter that helps to implement filtering.
///
/// Process Example:
/// ```dart
/// TODO: Missing Docs
///
/// ```
/// {@endtemplate}
abstract class FilterAdapter<R, F extends BaseFilterable> {
  /// The Filter that this adapter can handle.
  ///
  /// Example:
  /// ```dart
  /// class MyAdapter extends FilterableTypeAdapter<MyData, MyFilter>{
  /// // ...
  /// }
  ///
  /// final adapter = MyAdapter();
  /// print(adapter.adapterOfFilter); // (Type) MyFilter
  /// ```
  @nonVirtual
  Type adapterOfFilter = F;

  /// Returns the filtered Data
  ///
  /// TODO: Missing Docs
  R getFilteredData(
    R data,
    F filter, {
    required List<String> fieldPath,
    required bool descending,
  });
}

/// {@template filter_adapters}
/// A list of [FilterAdapter]s
/// {@endtemplate}
class FilterAdapterGroup<R> {
  /// {@macro filter_adapters}
  const FilterAdapterGroup(this.adapters);

  /// An empty [FilterAdapterGroup] list
  const FilterAdapterGroup.empty() : adapters = const [];

  /// The list of [FilterAdapter]s
  final List<FilterAdapter<R, BaseFilterable>> adapters;
}

/// {@template default_filter_adapters}
/// {@macro filter_adapters}
///
/// All of the default adapters are required.
/// {@endtemplate}
class DefaultFilterAdapters<R> extends FilterAdapterGroup<R> {
  /// {@macro default_filter_adapters}
  DefaultFilterAdapters({
    // DateTime
    required this.dateFilterAdapter,
    required this.dateRangeFilterAdapter,
    // Int
    required this.intFilterAdapter,
    required this.intRangeFilterAdapter,

    // String
    required this.stringFilterAdapter,

    // Custom Types
    List<FilterAdapter<R, BaseFilterable>>? customAdapters,
  }) : super([
          dateFilterAdapter,
          dateRangeFilterAdapter,
          intFilterAdapter,
          intRangeFilterAdapter,
          stringFilterAdapter,
          if (customAdapters != null) ...customAdapters,
        ]);

  /// [DateTimeFilter]'s [FilterAdapter]
  final FilterAdapter<R, DateTimeFilter> dateFilterAdapter;

  /// [DateTimeRangeFilter]'s [FilterAdapter]
  final FilterAdapter<R, DateTimeRangeFilter> dateRangeFilterAdapter;

  /// [IntFilter]'s [FilterAdapter]
  final FilterAdapter<R, IntFilter> intFilterAdapter;

  /// [IntRangeFilter]'s [FilterAdapter]
  final FilterAdapter<R, IntRangeFilter> intRangeFilterAdapter;

  /// [StringFilter]'s [FilterAdapter]
  final FilterAdapter<R, StringFilter> stringFilterAdapter;
}
