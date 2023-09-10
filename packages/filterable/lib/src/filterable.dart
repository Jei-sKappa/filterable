import 'package:filterable/src/base_type_filterable.dart';

/// {@template filterable}
/// A Dart package that helps to implement filtering
/// {@endtemplate}
abstract class Filterable {
  /// {@macro filterable}
  const Filterable();

  /// The list of filters
  List<FilterableField> get filters;
}

class FilterableField {
  const FilterableField({
    required this.fieldId,
    required this.typeFilterable,
  });

  final String fieldId;
  final BaseTypeFilterable typeFilterable;
}
