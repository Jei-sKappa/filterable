// ignore: lines_longer_than_80_chars
// ignore_for_file: implementation_imports, depend_on_referenced_packages, cascade_invocations

import 'package:analyzer/dart/element/element.dart';
import 'package:ansi_styles/extension.dart';
import 'package:build/build.dart';
import 'package:build/src/builder/build_step.dart';
import 'package:filterable_annotation/filterable_annotation.dart';
import 'package:filterable_generator/src/_model_visitor.dart';
import 'package:source_gen/source_gen.dart';

/// Generates a `*.filterable.dart` file for each annotated class.
class FilterableGenerator extends GeneratorForAnnotation<FilterableGen> {
  _FilterData? _getFilterDataFromFilterName(
    String newFilterName,
    List<_FilterData> filters,
  ) {
    for (final filter in filters) {
      if (filter.filterName == newFilterName) {
        return filter;
      }
    }

    return null;
  }

  String _codeAnsi(String value) => value.bold.italic.underline;

  String _getExistingFilterNameErrorMessage(
    _FilterData filter,
    String filterDartType,
    String filterName,
  ) =>
      '(${_codeAnsi("${filter.fieldType} ${filter.fieldName}")}) '
      'Cannot create ${_codeAnsi("$filterDartType $filterName")} because '
      'already exists the variable '
      '${_codeAnsi("${filter.filterDartType} ${filter.filterName}")}. '
      'Please, provide another name for $filterDartType or remove it.';

  @override
  String generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    final generateSafeFilter =
        annotation.objectValue.getField('generateSafeFilter')!.toBoolValue()!;
    final generateFields =
        annotation.objectValue.getField('generateFields')!.toBoolValue()!;
    final generateGetValueFromFieldsExtension = annotation.objectValue
        .getField('generateGetValueFromFieldsExtension')!
        .toBoolValue()!;
    final customFilterTypeSuffix = annotation.objectValue
        .getField('customFilterTypeSuffix')!
        .toStringValue()!;

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
    late final List<FieldData> classFields;
    if (classData.fields == null || classData.fields!.isEmpty) {
      // Try with constructorFields
      if (classData.constructorFields == null ||
          classData.constructorFields!.isEmpty) {
        throw StateError('Cannot generate a filter with no fields');
      } else {
        classFields = classData.constructorFields!;
      }
    } else {
      classFields = classData.fields!;
    }

    // Create a list of all filters
    final filters = <_FilterData>[];
    for (final fieldData in classFields) {
      var hasAddedFilter = false;

      // Remove Nullability from Type
      // String? -> String (=> String?Filter -> StringFilter)
      final fieldTypeWithoutNullability = fieldData.type.replaceFirst('?', '');
      late bool isNullable;
      if (fieldTypeWithoutNullability != fieldData.type) {
        isNullable = true;
      } else {
        isNullable = false;
      }

      // Make field's type with first letter in upper case
      // int -> Int (=> intFilter -> IntFilter)
      final baseFilterDartType = fieldTypeWithoutNullability.replaceFirst(
        fieldData.type[0],
        fieldData.type[0].toUpperCase(),
      );

      for (final customFilter in fieldData.customFilters) {
        final filterDartType =
            customFilter.filter ?? '$baseFilterDartType$customFilterTypeSuffix';
        final filterName = customFilter.name ?? '${fieldData.name}Filter';

        final existingFilterWithSameName =
            _getFilterDataFromFilterName(filterName, filters);
        if (existingFilterWithSameName != null) {
          throw StateError(
            _getExistingFilterNameErrorMessage(
              existingFilterWithSameName,
              filterDartType,
              filterName,
            ),
          );
        }

        filters.add(
          _CustomFilterData(
            customFilter: customFilter,
            fieldType: fieldData.type,
            fieldName: fieldData.name,
            fieldKey: fieldData.fieldKey,
            filterName: filterName,
            filterDartType: filterDartType,
          ),
        );
        hasAddedFilter = true;
      }

      for (final rangeFilter in fieldData.rangeFilters) {
        // Create a var with fieldData.name! with the first letter in upper case
        final fieldNameWithFirstLetterUpperCase = fieldData.name
            .replaceFirst(fieldData.name[0], fieldData.name[0].toUpperCase());

        var minParameterName = 'min$fieldNameWithFirstLetterUpperCase';
        var maxParameterName = 'max$fieldNameWithFirstLetterUpperCase';

        final filterDartType = '${baseFilterDartType}RangeFilter';
        late final String filterName;
        if (rangeFilter.name == null) {
          filterName = '${fieldData.name}RangeFilter';
        } else {
          filterName = rangeFilter.name!;

          // Update Parameters Name to avoid collisions
          final fixedName = filterName.replaceFirst(
            filterName[0],
            filterName[0].toUpperCase(),
          );
          minParameterName = '${minParameterName}Of$fixedName';
          maxParameterName = '${maxParameterName}Of$fixedName';
        }

        final existingFilterWithSameName =
            _getFilterDataFromFilterName(filterName, filters);
        if (existingFilterWithSameName != null) {
          throw StateError(
            _getExistingFilterNameErrorMessage(
              existingFilterWithSameName,
              filterDartType,
              filterName,
            ),
          );
        }

        filters.add(
          _RangeFilterData(
            rangeFilter: rangeFilter,
            fieldType: fieldData.type,
            fieldName: fieldData.name,
            fieldKey: fieldData.fieldKey,
            // RangeFilter has 2 parameters: min and max
            // they should be nullable
            minFilterParameter: _FilterParameter(
              // Add Nullability to Type
              baseType: fieldTypeWithoutNullability,
              isNullable: true,
              name: minParameterName,
              fieldName: 'min',
            ),
            maxFilterParameter: _FilterParameter(
              // Add Nullability to Type
              baseType: fieldTypeWithoutNullability,
              isNullable: true,
              name: maxParameterName,
              fieldName: 'max',
            ),
            filterName: filterName,
            filterDartType: filterDartType,
          ),
        );
        hasAddedFilter = true;
      }

      // If no filter is provided (or only a ValueFilter) defaults
      // to [ValueFilter]
      late final List<ValueFilter> fixedValueFilters;
      if (!hasAddedFilter && fieldData.valueFilters.isEmpty) {
        fixedValueFilters = [const ValueFilter()];
      } else {
        fixedValueFilters = fieldData.valueFilters;
      }
      for (final valueFilter in fixedValueFilters) {
        final filterDartType = '${baseFilterDartType}Filter';

        var parameterName = fieldData.name;

        late final String filterName;
        if (valueFilter.name == null) {
          filterName = '${fieldData.name}Filter';
        } else {
          filterName = valueFilter.name!;

          // Update Parameters Name to avoid collisions
          final fixedName = filterName.replaceFirst(
            filterName[0],
            filterName[0].toUpperCase(),
          );
          parameterName = '${parameterName}Of$fixedName';
        }

        final existingFilterWithSameName =
            _getFilterDataFromFilterName(filterName, filters);
        if (existingFilterWithSameName != null) {
          throw StateError(
            _getExistingFilterNameErrorMessage(
              existingFilterWithSameName,
              filterDartType,
              filterName,
            ),
          );
        }

        filters.add(
          _ValueFilterData(
            valueFilter: valueFilter,
            fieldType: fieldData.type,
            fieldName: fieldData.name,
            fieldKey: fieldData.fieldKey,
            filterParameter: _FilterParameter(
              baseType: fieldTypeWithoutNullability,
              isNullable: isNullable,
              name: fieldData.name,
              fieldName: 'value',
            ),
            filterName: filterName,
            filterDartType: filterDartType,
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
    final generatedAdaptersName = '${classData.name}Adapters';
    buffer.writeln('/// {@template ${element.name}}');
    buffer.writeln("/// [${element.name}]'s [Filterable]");
    buffer.writeln('/// {@endtemplate}');
    buffer.writeln('class $generatedClassName extends Filterable {');

    // Constructor Parameters Start
    buffer.writeln('/// {@macro ${element.name}}');
    buffer.writeln('$generatedClassName({');

    // Constructor Parameters Fields
    for (final filter in filters) {
      buffer.writeln(
        '/// Parameters used by ${filter.filterName} to filter [${classData.name}]s',
      );
      final filterParameters = filter.getFilterParameters();
      if (filterParameters == null) {
        // ignore: lines_longer_than_80_chars
        buffer.writeln(
          'required ${filter.filterDartType} ${filter.filterName},',
        );
      } else {
        for (final parameter in filterParameters) {
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
      buffer.writeln('${filter.filterName} =');
      final filterParameters = filter.getFilterParameters();
      if (filterParameters == null) {
        buffer.writeln(filter.filterName);
      } else {
        buffer.writeln(filter.filterDartType);
        buffer.writeln('(');
        for (final parameter in filterParameters) {
          buffer.writeln('${parameter.name},');
        }
        buffer.writeln(')');
      }

      // Line Terminator
      if (i == filters.length - 1) {
        buffer.writeln(';');
      } else {
        buffer.writeln(',');
      }
    }

    // Constructor Parameters Fields End

    buffer.writeln();

    // Filters Declaration
    for (final filter in filters) {
      buffer.writeln(
          "/// The filter for [${classData.name}]'s ${filter.fieldName}");
      buffer.writeln('final ${filter.filterDartType} ${filter.filterName};');
      buffer.writeln();
    }

    // Override get filters Start
    buffer.writeln('@override');
    buffer.writeln('List<FilterableField> get filters => [');

    // Determine the name of the field that will be used as an identifier
    late final String enumIdentifierFieldName;
    final idNameOptions = <String>[
      'id',
      'identifier',
      'key',
      'fieldId',
      'fieldIndentifier',
      'fieldKey',
    ];

    var hasFindedId = false;
    for (final idName in idNameOptions) {
      if (!classFields.any((field) => field.name == idName)) {
        enumIdentifierFieldName = idName;
        hasFindedId = true;
        break;
      }
    }
    if (!hasFindedId) {
      var i = 0;
      while (!hasFindedId) {
        i++;
        final sequenceId = 'id$i';
        if (!classFields.any((field) => field.name == sequenceId)) {
          enumIdentifierFieldName = sequenceId;
          hasFindedId = true;
        }
      }
    }

    //
    for (final filter in filters) {
      // FilterableField Start
      buffer.writeln('FilterableField(');

      // FieldId
      if (generateFields) {
        buffer.writeln(
          // ignore: lines_longer_than_80_chars
          'fieldId: $generatedEnumName.${filter.fieldName}.$enumIdentifierFieldName,',
        );
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

    // SafeFilter Function Start
    if (generateSafeFilter) {
      buffer.writeln('''
      /// A wrapper around [$generatedClassName].[filter].
      /// The only difference is that [safeFilter]
      /// require to pass all the necessary adapters in
      /// order to correctly filter the Object.
      /// 
      /// This totally* excludes runtime errors.
      /// 
      /// (*) This is not 100% true, because it depends on
      /// your implementation of the adapters.      
      T safeFilter<T>(
        T data, {
        bool descending = false,
        required List<String> fieldPath,
        required $generatedAdaptersName<T> adapterGroup,
      }) =>
          super.filter(
            data,
            fieldPath: fieldPath,
            descending: descending,
            adapters: adapterGroup.adapters,
          );
      ''');
    }

    // CopyWith Parameters Start
    buffer.writeln('/// Creates a copy of [$generatedClassName] with');
    buffer.writeln('/// the specified fields replaced with the new values.');
    buffer.writeln('$generatedClassName copyWith({');

    //
    for (final filter in filters) {
      final filterParameters = filter.getFilterParameters();
      if (filterParameters == null) {
        buffer.writeln('${filter.filterDartType}? ${filter.filterName},');
      } else {
        for (final parameter in filterParameters) {
          // If the parameter is nullable, it should be wrapped in a Function
          // to be able to use the null-aware operator
          final maybeFunction = parameter.isNullable ? 'Function()?' : '';
          buffer.writeln(
            '${parameter.baseType}? $maybeFunction ${parameter.name},',
          );
        }
      }
    }

    // CopyWith Parameters End
    buffer.writeln('})');

    // CopyWith Body Start
    buffer.writeln('=> $generatedClassName(');

    //
    for (final filter in filters) {
      final filterParameters = filter.getFilterParameters();
      if (filterParameters == null) {
        // ignore: lines_longer_than_80_chars
        // buffer.writeln(
        //   'required ${filter.filterDartType} ${filter.filterName},',
        // );
        buffer.writeln('${filter.filterName}: ${filter.filterName}');
        buffer.writeln(' ?? ');
        buffer.writeln('this.${filter.filterName},');
      } else {
        for (final parameter in filterParameters) {
          // If the parameter is nullable, it should be wrapped in a Function
          // to be able to use the null-aware operator
          if (parameter.isNullable) {
            buffer.writeln('${parameter.name}: ${parameter.name}');
            buffer.writeln(' != null ');
            buffer.writeln(' ? ');
            buffer.writeln('${parameter.name}()');
            buffer.writeln(' : ');
            buffer.writeln('${filter.filterName}.${parameter.fieldName}');
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
            buffer.writeln(fallBackString);
          }
          buffer.writeln(',');
        }
      }
    }

    // CopyWith Body End
    buffer.writeln(');');

    buffer.writeln();

    // Class End
    buffer.writeln('}');

    // AdapterGroup Generator
    if (generateSafeFilter) {
      // AdapterGroup Start
      buffer.writeln('/// {@template $generatedAdaptersName}');
      buffer.writeln("/// [${element.name}]'s [FilterAdapterGroup].");
      buffer.writeln('/// Used to generate the safeFilter function.');
      buffer.writeln('/// {@endtemplate}');
      // ignore: lines_longer_than_80_chars
      buffer.writeln(
        'class $generatedAdaptersName<T> extends FilterAdapterGroup<T> {',
      );

      //
      // Make it a set of <String,String>
      final allUniqueRequestedFilterData = filters.map(
        (filter) {
          final filterDartType = filter.filterDartType;
          final adapterOfFilterName =
              // ignore: lines_longer_than_80_chars
              '${filterDartType.replaceFirst(filterDartType[0], filterDartType[0].toLowerCase())}Adapter';

          return (
            filterDartType: filterDartType,
            adapterOfFilterName: adapterOfFilterName,
          );
        },
      ).toSet();

      // AdapterGroup Constructor Start
      buffer.writeln('/// {@macro $generatedAdaptersName}');
      buffer.writeln('$generatedAdaptersName({');

      //
      for (final filterData in allUniqueRequestedFilterData) {
        final adapterOfFilterName = filterData.adapterOfFilterName;

        buffer.writeln(
          // ignore: lines_longer_than_80_chars
          'required this.$adapterOfFilterName,',
        );
      }

      // AdapterGroup Constructor End
      buffer.writeln('})');

      // AdapterGroup Constructor Body Start
      buffer.writeln(': super([');

      //
      for (final filterData in allUniqueRequestedFilterData) {
        buffer.writeln('${filterData.adapterOfFilterName},');
      }

      // AdapterGroup Constructor Body End
      buffer.writeln(']);');

      buffer.writeln();

      // AdapterGroup Fields
      for (final filterData in allUniqueRequestedFilterData) {
        final filterDartType = filterData.filterDartType;
        final adapterOfFilterName = filterData.adapterOfFilterName;

        buffer.writeln(
          "/// [$filterDartType]'s [FilterAdapter]",
        );
        buffer.writeln(
          'final FilterAdapter<T, $filterDartType> $adapterOfFilterName;',
        );
        buffer.writeln();
      }

      // AdapterGroup End
      buffer.writeln('}');
    }

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
    buffer.writeln('const $generatedEnumName(this.$enumIdentifierFieldName);');

    // enum Custom Fields
    buffer.writeln('/// The identifier of the field');
    buffer.writeln('final String $enumIdentifierFieldName;');

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
    // ignore: lines_longer_than_80_chars
    buffer.writeln(
      'extension ${classData.name}GetValueFromFields on ${classData.name} {',
    );

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

  List<_FilterParameter>? getFilterParameters();
}

class _FilterParameter {
  _FilterParameter({
    required this.name,
    required this.baseType,
    required this.isNullable,
    required this.fieldName,
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

  String get fullType => isNullable ? '$baseType?' : baseType;
}

class _CustomFilterData extends _FilterData {
  _CustomFilterData({
    required CustomFilter customFilter,
    required super.fieldType,
    required super.fieldName,
    required super.fieldKey,
    required super.filterName,
    required super.filterDartType,
  }) : super(
          filterType: customFilter,
        );

  @override
  List<_FilterParameter>? getFilterParameters() => null;
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
