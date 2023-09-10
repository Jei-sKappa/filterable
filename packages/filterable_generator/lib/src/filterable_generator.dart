// ignore: lines_longer_than_80_chars
// ignore_for_file: implementation_imports, depend_on_referenced_packages, cascade_invocations

import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:build/src/builder/build_step.dart';
import 'package:filterable_annotation/filterable_annotation.dart';
import 'package:filterable_generator/src/_model_visitor.dart';
import 'package:source_gen/source_gen.dart';

/// Generates a `*.filterable.dart` file for each annotated class.
class FilterableGenerator extends GeneratorForAnnotation<FilterableAnnotation> {
  @override
  String generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    final visitor = ModelVisitor();

    // Fills ClassData in [visitor]
    element.visitChildren(visitor);

    final classData = visitor.classData;

    // Check Validity
    if (classData.fields == null || classData.fields!.isEmpty) {
      throw StateError('Cannot generate a filter with no fields');
    }

    final classFields = classData.fields!;

    // Make sure there are not duplicate annotations:
    for (final fieldData in classFields) {
      if (fieldData.rangeFilters.length > 1) {
        throw StateError(
            '(${fieldData.name}) A field must constain only 1 annotation from:'
            ' @RangeFilter');
      }
      if (fieldData.valueFilters.length > 1) {
        throw StateError(
            '(${fieldData.name}) A field must constain only 1 annotation from:'
            ' @ValueFilter');
      }
    }

    // Create a list of all filters
    final filters = <_FilterData>[];
    for (final fieldData in classFields) {
      final rangeFilter = fieldData.rangeFilters.firstOrNull;
      final valueFilter = fieldData.valueFilters.firstOrNull;

      var hasAddedFilter = false;

      final fieldTypeWithFirstLetterUpperCase = fieldData.type!
          .replaceFirst(fieldData.type![0], fieldData.type![0].toUpperCase());

      if (rangeFilter != null) {
        // Create a var with fieldData.name! with the first letter in upper case
        final fieldNameWithFirstLetterUpperCase = fieldData.name!
            .replaceFirst(fieldData.name![0], fieldData.name![0].toUpperCase());

        filters.add(
          _RangeFilterData(
            filterMode: rangeFilter,
            fieldType: fieldData.type!,
            fieldName: fieldData.name!,
            minFilterParameter: 'min$fieldNameWithFirstLetterUpperCase',
            maxFilterParameter: 'max$fieldNameWithFirstLetterUpperCase',
            name: '${fieldData.name!}RangeFilter',
            type: '${fieldTypeWithFirstLetterUpperCase}RangeFilter',
          ),
        );
        hasAddedFilter = true;
      }

      // If no filter is provided (or only a ValueFilter) defaults
      // to [ValueFilter]
      if (!hasAddedFilter || valueFilter != null) {
        filters.add(
          _ValueFilterData(
            filterMode: valueFilter ?? const ValueFilter(),
            fieldType: fieldData.type!,
            fieldName: fieldData.name!,
            filterParameter: fieldData.name!,
            name: '${fieldData.name!}Filter',
            type: '${fieldTypeWithFirstLetterUpperCase}Filter',
          ),
        );
        hasAddedFilter = true;
      }
    }

    // Generate Code
    final buffer = StringBuffer();

    // Class Start
    final generatedClassName = '${classData.name}Filterable';
    buffer.writeln('/// Filter of ${element.name}');
    buffer.writeln('class $generatedClassName extends Filterable {');

    // Constructor Parameters Start
    buffer.writeln('$generatedClassName({');

    // Constructor Parameters Fields
    for (final filter in filters) {
      final prefixLine = 'required ${filter.fieldType}';
      const suffixLine = ',';
      for (final fieldName in filter.getFilterParameters()) {
        buffer.writeln('$prefixLine $fieldName $suffixLine');
      }
    }

    // Constructor Parameters End
    buffer.writeln('})');
    buffer.writeln(':');

    // Constructor Parameters Fields Start: initialize actual filters
    for (var i = 0; i < filters.length; i++) {
      final filter = filters[i];

      // Type Filter Start
      buffer.writeln('${filter.name} = ${filter.type}');
      buffer.writeln('(');
      for (final parameter in filter.getFilterParameters()) {
        buffer.writeln('$parameter,');
      }
      buffer.writeln(')');

      // Line Terminator
      if (i == filters.length - 1) {
        buffer.writeln(';');
      } else {
        buffer.writeln(',');
      }
    }

    buffer.writeln();

    // Filters Declaration
    for (final filter in filters) {
      buffer.writeln('final ${filter.type} ${filter.name};');
      buffer.writeln();
    }

    // Override get filters Start
    buffer.writeln('@override');
    buffer.writeln('List<FilterableField> get filters => [');

    //
    for (final filter in filters) {
      // FilterableField Start
      buffer.writeln('FilterableField(');

      // FieldId
      buffer.writeln("fieldId: '${filter.fieldName}',");

      // TypeFilterable
      buffer.writeln('typeFilterable: ${filter.name},');

      // FilterableField End
      buffer.writeln('),');
    }

    // Override get filters End
    buffer.writeln('];');

    // Class End
    buffer.writeln('}');

    return buffer.toString();
  }
}

sealed class _FilterData {
  _FilterData({
    required this.filterMode,
    required this.fieldType,
    required this.fieldName,
    required this.name,
    required this.type,
  });

  final FilterMode filterMode;
  final String fieldType;
  final String fieldName;
  final String name;
  final String type;

  List<String> getFilterParameters();
}

class _ValueFilterData extends _FilterData {
  _ValueFilterData({
    required super.filterMode,
    required super.fieldType,
    required super.fieldName,
    required super.name,
    required super.type,
    required this.filterParameter,
  });

  final String filterParameter;

  @override
  List<String> getFilterParameters() => [filterParameter];
}

class _RangeFilterData extends _FilterData {
  _RangeFilterData({
    required super.filterMode,
    required super.fieldType,
    required super.fieldName,
    required super.name,
    required super.type,
    required this.minFilterParameter,
    required this.maxFilterParameter,
  });

  final String minFilterParameter;
  final String maxFilterParameter;

  @override
  List<String> getFilterParameters() => [
        minFilterParameter,
        maxFilterParameter,
      ];
}
