// ignore_for_file: depend_on_referenced_packages
// ignore_for_file: public_member_api_docs

import 'package:analyzer/dart/constant/value.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/visitor.dart';
import 'package:filterable_annotation/filterable_annotation.dart';
import 'package:source_gen/source_gen.dart';

const _rangeFilterAnnotation = TypeChecker.fromRuntime(RangeFilter);
const _valueFilterAnnotation = TypeChecker.fromRuntime(ValueFilter);
const _customFilterAnnotation = TypeChecker.fromRuntime(CustomFilter);
const _ignoreAnnotation = TypeChecker.fromRuntime(Ignore);
const _fieldKeyAnnotation = TypeChecker.fromRuntime(FieldKey);

class ModelVisitor extends SimpleElementVisitor<void> {
  ClassData classData = ClassData();

  @override
  void visitConstructorElement(ConstructorElement element) {
    final returnType = element.returnType.toString();
    classData.name = returnType.replaceFirst('*', '');
    // This should be a factory constructor with no name:
    // default constructor
    if (element.isFactory && element.name == '') {
      for (final parameter in element.parameters) {
        final fieldData = FieldData.fromElement(parameter);
        classData.fields ??= <FieldData>[];
        classData.fields!.add(fieldData);
      }
    }
  }

  @override
  void visitFieldElement(FieldElement element) {
    final fieldData = FieldData.fromElement(element);
    classData.fields ??= <FieldData>[];
    classData.fields!.add(fieldData);
  }
}

class ClassData {
  ClassData({
    this.name,
    this.fields,
    this.constructorFields,
  });

  String? name;
  List<FieldData>? fields;
  List<FieldData>? constructorFields;
}

class FieldData {
  FieldData({
    required this.name,
    required this.type,
    required this.rangeFilters,
    required this.valueFilters,
    required this.customFilters,
    required this.ignoreAnnotations,
    required this.fieldKey,

  });

  factory FieldData.fromElement(Element element) {
    RangeFilter getRangeFilter(DartObject annotation) {
      final name = annotation.getField('name')!.toStringValue();
      return RangeFilter(name);
    }

    ValueFilter getValueFilter(DartObject annotation) {
      final name = annotation.getField('name')!.toStringValue();
      return ValueFilter(name);
    }

    CustomFilter getCustomFilter(DartObject annotation) {
      final filter = annotation.getField('filter')!.toStringValue();
      final name = annotation.getField('name')!.toStringValue();
      return CustomFilter.named(
        name,
        filter: filter,
      );
    }

    Ignore getIgnoreAnnotation(DartObject annotation) {
      final ignoreField = annotation.getField('ignoreField')!.toBoolValue()!;
      return Ignore(
        ignoreField: ignoreField,
      );
    }

    // Field Type
    late final String fieldType;
    switch (element) {
      case final FieldElement fieldElement:
        fieldType = fieldElement.type.toString().replaceFirst('*', '');
      case final ParameterElement parameterElement:
        fieldType = parameterElement.type.toString().replaceFirst('*', '');
      default:
        throw Exception('Element must be a FieldElement or a ParameterElement');
    }

    // Field name
    final fieldName = element.name;
    if (fieldName == null) {
      throw Exception('Field name must not be null');
    }

    // RangeFilter
    final rangeAnnotations = <RangeFilter>[];
    _rangeFilterAnnotation.annotationsOfExact(element).forEach((annotation) {
      final rangeFilter = getRangeFilter(annotation);
      rangeAnnotations.add(rangeFilter);
    });

    // ValueFilter
    final valueAnnotations = <ValueFilter>[];
    _valueFilterAnnotation.annotationsOfExact(element).forEach((annotation) {
      final valueFilter = getValueFilter(annotation);
      valueAnnotations.add(valueFilter);
    });

    // CustomFilter
    final customAnnotations = <CustomFilter>[];
    _customFilterAnnotation.annotationsOfExact(element).forEach((annotation) {
      final customFilter = getCustomFilter(annotation);
      customAnnotations.add(customFilter);
    });

    // Ignore
    final ignoreAnnotations = <Ignore>[];
    _ignoreAnnotation.annotationsOfExact(element).forEach((annotation) {
      final ignoreAnnotation = getIgnoreAnnotation(annotation);
      ignoreAnnotations.add(ignoreAnnotation);
    });
    

    // FieldKey
    FieldKey? fieldKey;
    _fieldKeyAnnotation.annotationsOfExact(element).forEach((annotation) {
      final key = annotation.getField('key')!.toStringValue()!;
      fieldKey = FieldKey(key);
    });

    return FieldData(
      name: fieldName,
      type: fieldType,
      rangeFilters: rangeAnnotations,
      valueFilters: valueAnnotations,
      customFilters: customAnnotations,
      ignoreAnnotations: ignoreAnnotations,
      fieldKey: fieldKey,
    );
  }

  String name;
  String type;
  List<RangeFilter> rangeFilters;
  List<ValueFilter> valueFilters;
  List<CustomFilter> customFilters;
  List<Ignore> ignoreAnnotations;
  FieldKey? fieldKey;
}
