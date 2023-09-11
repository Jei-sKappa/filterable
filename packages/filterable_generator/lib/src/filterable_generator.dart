// ignore: lines_longer_than_80_chars
// ignore_for_file: implementation_imports, depend_on_referenced_packages, cascade_invocations

import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:build/src/builder/build_step.dart';
import 'package:filterable_annotation/filterable_annotation.dart';
import 'package:filterable_generator/src/_model_visitor.dart';
import 'package:source_gen/source_gen.dart';

/// Generates a `*.filterable.dart` file for each annotated class.
class FilterableGenerator extends GeneratorForAnnotation<FilterableGen> {
  @override
  String generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    final generateFields =
        annotation.objectValue.getField('generateFields')!.toBoolValue()!;
    final generateGetValueFromFieldsExtension = annotation.objectValue
        .getField('generateGetValueFromFieldsExtension')!
        .toBoolValue()!;

    if (!generateFields && generateGetValueFromFieldsExtension) {
      throw StateError(
        'If you want to generate the extension, you must generate the fields',
      );
    }

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

      // Remove Nullability from Type
      // String? -> String (=> String?Filter -> StringFilter)
      final fieldTypeWithoutNullability = fieldData.type!.replaceFirst('?', '');
      late bool isNullable;
      if (fieldTypeWithoutNullability != fieldData.type!) {
        isNullable = true;
      } else {
        isNullable = false;
      }

      // Make field's type with first letter in upper case
      // int -> Int (=> intFilter -> IntFilter)
      final baseFilterDartType = fieldTypeWithoutNullability.replaceFirst(
        fieldData.type![0],
        fieldData.type![0].toUpperCase(),
      );

      if (rangeFilter != null) {
        // Create a var with fieldData.name! with the first letter in upper case
        final fieldNameWithFirstLetterUpperCase = fieldData.name!
            .replaceFirst(fieldData.name![0], fieldData.name![0].toUpperCase());

        filters.add(
          _RangeFilterData(
            rangeFilter: rangeFilter,
            fieldType: fieldData.type!,
            fieldName: fieldData.name!,
            fieldKey: fieldData.fieldKey,
            // RangeFilter has 2 parameters: min and max
            // they should be nullable
            minFilterParameter: _FilterParameter(
              // Add Nullability to Type
              baseType: fieldTypeWithoutNullability,
              isNullable: true,
              name: 'min$fieldNameWithFirstLetterUpperCase',
              fieldName: 'min',
              defaultValue: rangeFilter.defaultMin,
            ),
            maxFilterParameter: _FilterParameter(
              // Add Nullability to Type
              baseType: fieldTypeWithoutNullability,
              isNullable: true,
              name: 'max$fieldNameWithFirstLetterUpperCase',
              fieldName: 'max',
              defaultValue: rangeFilter.defaultMax,
            ),
            filterName: '${fieldData.name!}RangeFilter',
            filterDartType: '${baseFilterDartType}RangeFilter',
          ),
        );
        hasAddedFilter = true;
      }

      // If no filter is provided (or only a ValueFilter) defaults
      // to [ValueFilter]
      if (!hasAddedFilter || valueFilter != null) {
        filters.add(
          _ValueFilterData(
            valueFilter: valueFilter ?? const ValueFilter(),
            fieldType: fieldData.type!,
            fieldName: fieldData.name!,
            fieldKey: fieldData.fieldKey,
            filterParameter: _FilterParameter(
              baseType: fieldTypeWithoutNullability,
              isNullable: isNullable,
              name: fieldData.name!,
              fieldName: 'value',
              defaultValue: valueFilter?.defaultValue,
            ),
            filterName: '${fieldData.name!}Filter',
            filterDartType: '${baseFilterDartType}Filter',
          ),
        );
        hasAddedFilter = true;
      }
    }

    // Generate Code
    final buffer = StringBuffer();

    // Class Start
    final generatedClassName = '${classData.name}Filterable';
    final generatedEnumName = '${classData.name}Field';
    buffer.writeln('/// Filter of ${element.name}');
    buffer.writeln('class $generatedClassName extends Filterable {');

    // Constructor Parameters Start
    buffer.writeln('$generatedClassName({');

    // Constructor Parameters Fields
    for (final filter in filters) {
      for (final parameter in filter.getFilterParameters()) {
        // Include Defaults in Constructor
        // Its true only if the filter has a default value
        late bool includeDefaultsInConstructor;
        switch (filter.filterType) {
          case final ValueFilter valueFilter:
            includeDefaultsInConstructor =
                valueFilter.includeDefaultsInConstructor;
          case final RangeFilter rangeFilter:
            includeDefaultsInConstructor =
                rangeFilter.includeDefaultsInConstructor;
        }
        if (includeDefaultsInConstructor && parameter.defaultValue != null) {
          buffer.writeln(
            // ignore: lines_longer_than_80_chars
            '${parameter.fullType} ${parameter.name} = ${parameter.getDefaultNameForParameter()!},',
          );
        } else {
          buffer.writeln(
            'required ${parameter.fullType} ${parameter.name},',
          );
        }
      }
    }

    // Constructor Parameters End
    buffer.writeln('})');
    buffer.writeln(':');

    // Constructor Parameters Fields Start: initialize actual filters
    for (var i = 0; i < filters.length; i++) {
      final filter = filters[i];

      // Type Filter Start
      buffer.writeln('${filter.filterName} = ${filter.filterDartType}');
      buffer.writeln('(');
      for (final parameter in filter.getFilterParameters()) {
        buffer.writeln('${parameter.name},');
      }
      buffer.writeln(')');

      // Line Terminator
      if (i == filters.length - 1) {
        buffer.writeln(';');
      } else {
        buffer.writeln(',');
      }
    }

    // Constructor Parameters Fields End

    buffer.writeln();

    // Constructor.initial Parameters Start
    buffer.writeln('$generatedClassName.withDefaults(');

    // Constructor.initial Parameters Fields
    // ParameterName, DefaultValue
    final parametersWithDefaultValue = <String, _FilterParameter>{};
    final parametersWithoutDefaultValue = <_FilterParameter>[];
    // var allFieldsHaveDefaultValue = true;
    // Fill data
    for (final filter in filters) {
      for (final parameter in filter.getFilterParameters()) {
        if (parameter.defaultValue != null) {
          parametersWithDefaultValue[parameter.name] = parameter;
        } else {
          parametersWithoutDefaultValue.add(parameter);
        }
      }
    }

    if (parametersWithoutDefaultValue.isNotEmpty) {
      buffer.writeln('{');

      for (final parameter in parametersWithoutDefaultValue) {
        buffer.writeln(
          'required ${parameter.fullType} ${parameter.name},',
        );
      }

      buffer.writeln('}');
    }

    // Constructor.initial Parameters End
    buffer.writeln(')');

    // Constructor.initial Body Start
    buffer.writeln(': this(');

    //
    buffer.writeln('/// Default Values');
    for (final entry in parametersWithDefaultValue.entries) {
      final parameter = entry.value;
      final defaultValueVarName = parameter.getDefaultNameForParameter()!;
      buffer.writeln('${entry.key}: $defaultValueVarName,');
    }

    //
    buffer.writeln('/// Non-Default Values');
    for (final parameter in parametersWithoutDefaultValue) {
      buffer.writeln('${parameter.name}: ${parameter.name},');
    }

    // Constructor.initial Body End
    buffer.writeln(');');

    buffer.writeln();

    // Filters Declaration
    for (final filter in filters) {
      buffer.writeln('final ${filter.filterDartType} ${filter.filterName};');
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
      if (generateFields) {
        buffer.writeln('fieldId: $generatedEnumName.${filter.fieldName}.id,');
      } else {
        buffer.writeln("fieldId: '${filter.fieldKey}',");
      }

      // TypeFilterable
      buffer.writeln('typeFilterable: ${filter.filterName},');

      // FilterableField End
      buffer.writeln('),');
    }

    // Override get filters End
    buffer.writeln('];');

    buffer.writeln();

    // CopyWith Parameters Start
    buffer.writeln('$generatedClassName copyWith({');

    //
    for (final filter in filters) {
      for (final parameter in filter.getFilterParameters()) {
        // If the parameter is nullable, it should be wrapped in a Function
        // to be able to use the null-aware operator
        final maybeFunction = parameter.isNullable ? 'Function()?' : '';
        buffer.writeln(
          '${parameter.baseType}? $maybeFunction ${parameter.name},',
        );
      }
    }

    // CopyWith Parameters End
    buffer.writeln('})');

    // CopyWith Body Start
    buffer.writeln('=> $generatedClassName(');

    //
    for (final filter in filters) {
      for (final parameter in filter.getFilterParameters()) {
        // If the parameter is nullable, it should be wrapped in a Function
        // to be able to use the null-aware operator
        if (parameter.isNullable) {
          buffer.writeln('${parameter.name}: ${parameter.name}');
          buffer.writeln(' != null ');
          buffer.writeln(' ? ');
          buffer.writeln('${parameter.name}()');
          buffer.writeln(' : ');
          buffer.writeln('${filter.filterName}.${parameter.fieldName},');
        } else {
          // ignore: lines_longer_than_80_chars
          final fallBackString =
              '(${filter.filterName}.${parameter.fieldName})!';
          buffer.writeln('/// It is used $fallBackString because');
          buffer.writeln(
            '/// [${filter.filterName}.${parameter.fieldName}] corresponds to [${parameter.name}] ',
          );
          buffer.writeln(
            '/// which is managed exclusively by [$generatedClassName]',
          );
          buffer.writeln(
            '/// and, as requested by the constructor, it cannot be null',
          );
          buffer.writeln('${parameter.name}: ${parameter.name}');
          buffer.writeln(' ?? ');
          buffer.writeln('$fallBackString,');
        }
      }
    }

    // CopyWith Body End
    buffer.writeln(');');

    buffer.writeln();

    // Defaults Fields Start
    for (final filter in filters) {
      for (final parameter in filter.getFilterParameters()) {
        buffer.writeln(
          '/// Default Values for ${parameter.name}',
        );
        final defaultValue = parameter.defaultValue;
        if (defaultValue != null) {
          final parameterNameWithFirstLetterUpperCase = parameter.name
              .replaceFirst(parameter.name[0], parameter.name[0].toUpperCase());

          buffer.writeln(
            // ignore: lines_longer_than_80_chars
            'static const ${parameter.fullType} ${parameter.getDefaultNameForParameter()!} = $defaultValue;',
          );
          buffer.writeln(
            'bool get is${parameterNameWithFirstLetterUpperCase}Default =>',
          );
          buffer.writeln(
            // ignore: lines_longer_than_80_chars
            '${filter.filterName}.${parameter.fieldName} == ${parameter.getDefaultNameForParameter()!};',
          );
        } else {
          buffer.writeln('/// No default value requested');
        }
        buffer.writeln();
      }
      buffer.writeln();
    }

    // Class End
    buffer.writeln('}');

    // Fields Generator
    if (!generateFields) {
      return buffer.toString();
    }

    //! Should Generate Fields

    buffer.writeln();

    // enum Start
    buffer.writeln('/// Fields of ${classData.name}');
    buffer.writeln('enum $generatedEnumName {');

    // enum fields
    for (var i = 0; i < classFields.length; i++) {
      final fieldData = classFields[i];
      buffer.writeln('/// The ${fieldData.name} of [${classData.name}]');
      buffer.writeln(
        "${fieldData.name}('${fieldData.fieldKey?.key ?? fieldData.name}')",
      );
      // Line Terminator
      if (i == classFields.length - 1) {
        buffer.writeln(';');
      } else {
        buffer.writeln(',');
      }

      buffer.writeln();
    }

    // enum Constructor
    buffer.writeln('const $generatedEnumName(this.id);');

    // enum Custom Fields
    // id
    buffer.writeln('final String id;');

    // enum End
    buffer.writeln('}');

    // Extension Generator
    if (!generateGetValueFromFieldsExtension) {
      return buffer.toString();
    }

    //! Should Generate Extension

    // Extension Start
    buffer.writeln('/// Extension on [${classData.name}] that adds:');
    buffer.writeln('/// - [getValueFromField]');
    buffer.writeln('/// - [getAllValuesFromFields]');
    buffer.writeln('extension GetValueFromFields on ${classData.name} {');

    // getValueFromField Start
    buffer
        .writeln('/// Returns the value of an instance of [${classData.name}]');
    buffer.writeln('/// based on a [$generatedEnumName]');
    buffer.writeln('dynamic getValueFromField($generatedEnumName field) {');

    // getValueFromField body Start
    buffer.writeln('switch (field) {');

    //
    for (final fieldData in classFields) {
      buffer.writeln('case $generatedEnumName.${fieldData.name}:');
      buffer.writeln('return ${fieldData.name};');
    }

    // getValueFromField body End
    buffer.writeln('}');

    // getValueFromField End
    buffer.writeln('}');

    // getAllValuesFromFields
    buffer.writeln('/// Returns a list of values of an instance of');
    buffer.writeln('/// [${classData.name}] based on a list of');
    buffer.writeln('/// [$generatedEnumName]');
    buffer.write('''
List<dynamic> getAllValuesFromFields(List<$generatedEnumName> fields) {
  final values = <dynamic>[];
  for (final field in fields) {
    values.add(getValueFromField(field));
  }

  return values;
}
''');

    // Extension End
    buffer.writeln('}');

    buffer.writeln();

    return buffer.toString();
  }
}

sealed class _FilterData {
  _FilterData({
    required this.filterType,
    required this.fieldType,
    required this.fieldName,
    required FieldKey? fieldKey,
    required this.filterName,
    required this.filterDartType,
  }) :
        // If no [fieldKey] is provided, defaults to [fieldName]
        fieldKey = fieldKey?.key ?? fieldName;

  final FilterType filterType;
  final String fieldType;
  final String fieldName;
  final String fieldKey;
  final String filterName;
  final String filterDartType;

  List<_FilterParameter> getFilterParameters();
}

class _FilterParameter {
  _FilterParameter({
    required this.name,
    required this.baseType,
    required this.isNullable,
    required this.fieldName,
    required this.defaultValue,
  });

  /// The name of the parameter
  final String name;

  /// The type without Nullability
  final String baseType;

  /// Whether the type is nullable or not
  final bool isNullable;

  /// The nameOf the field inside the filters
  /// For example for RangeFilter it would be:
  /// 'min' or 'max'
  final String fieldName;

  /// The default value for the parameter
  final String? defaultValue;

  String get fullType => isNullable ? '$baseType?' : baseType;

  /// Returns the default name for the parameter
  ///
  /// Can return null if default value is null
  String? getDefaultNameForParameter() {
    if (defaultValue == null) {
      return null;
    }

    final parameterNameWithFirstLetterUpperCase =
        name.replaceFirst(name[0], name[0].toUpperCase());

    return 'default$parameterNameWithFirstLetterUpperCase';
  }
}

class _ValueFilterData extends _FilterData {
  _ValueFilterData({
    required ValueFilter valueFilter,
    required super.fieldType,
    required super.fieldName,
    required super.fieldKey,
    required super.filterName,
    required super.filterDartType,
    required this.filterParameter,
  }) : super(
          filterType: valueFilter,
        );

  final _FilterParameter filterParameter;

  @override
  List<_FilterParameter> getFilterParameters() => [filterParameter];
}

class _RangeFilterData extends _FilterData {
  _RangeFilterData({
    required RangeFilter rangeFilter,
    required super.fieldType,
    required super.fieldName,
    required super.fieldKey,
    required super.filterName,
    required super.filterDartType,
    required this.minFilterParameter,
    required this.maxFilterParameter,
  }) : super(
          filterType: rangeFilter,
        );

  final _FilterParameter minFilterParameter;
  final _FilterParameter maxFilterParameter;

  @override
  List<_FilterParameter> getFilterParameters() => [
        minFilterParameter,
        maxFilterParameter,
      ];
}
