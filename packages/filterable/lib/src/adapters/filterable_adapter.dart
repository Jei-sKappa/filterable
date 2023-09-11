import 'package:filterable/src/filterable.dart';

abstract class FilterableAdapter<R> {
  R getFilteredData(
    R data,
    Filterable filterable, {
    required bool descending,
  });
}
