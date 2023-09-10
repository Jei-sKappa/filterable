// ignore_for_file: depend_on_referenced_packages, cascade_invocations

import 'package:analyzer/dart/constant/value.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/visitor.dart';
import 'package:filterable_annotation/filterable_annotation.dart';
import 'package:source_gen/source_gen.dart';

const _rangeFilterAnnotation = TypeChecker.fromRuntime(RangeFilter);
const _valueFilterAnnotation = TypeChecker.fromRuntime(ValueFilter);
// const _filterTypeAnnotation = TypeChecker.fromRuntime(FilterType);

class ModelVisitor extends SimpleElementVisitor<void> {
  ClassData classData = ClassData();

  @override
  void visitConstructorElement(ConstructorElement element) {
    final returnType = element.returnType.toString();
    classData.name = returnType.replaceFirst('*', '');
  }

  @override
  void visitFieldElement(FieldElement element) {
    final fieldData = FieldData.fromElement(element);
    classData.fields??= <FieldData>[];
    classData.fields!.add(fieldData);
  }
}

class ClassData {
  ClassData({
    this.name,
    this.fields,
  });

  String? name;
  List<FieldData>? fields;
}

class FieldData {
  FieldData({
    required this.name,
    required this.type,
    required this.rangeFilters,
    required this.valueFilters,
    // required this.filterTypes,
  });

  factory FieldData.fromElement(FieldElement element) {
    RangeFilter getRangeFilter(DartObject annotation) {
      return const RangeFilter();
    }

    ValueFilter getValueFilter(DartObject annotation) {
      return const ValueFilter();
    }

    // FilterType getFilterType(DartObject annotation) {
    //   final modes = <FilterMode>{};
    //   final modesList = annotation.getField('modes')?.toListValue();
    //   modesList?.forEach((mode) {
    //     if (mode.type is ValueFilter) {
    //       final valueFilter = getValueFilter(mode);
    //       modes.add(valueFilter);
    //     }
    //     if (mode.type is RangeFilter) {
    //       final rangeFilter = getRangeFilter(mode);
    //       modes.add(rangeFilter);
    //     }
    //   });

    //   return FilterType(modes: modes);
    // }

    // Field name
    final fieldName = element.name;

    // Field Type
    final fieldType = element.type.toString().replaceFirst('*', '');

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
    // // FilterType
    // final filterTypeAnnotations = <FilterType>[];
    // _filterTypeAnnotation.annotationsOfExact(element).forEach((annotation) {
    //   final filterType = getFilterType(annotation);
    //   filterTypeAnnotations.add(filterType);
    // });

    return FieldData(
      name: fieldName,
      type: fieldType,
      rangeFilters: rangeAnnotations,
      valueFilters: valueAnnotations,
      // filterTypes: filterTypeAnnotations,
    );
  }

  String? name;
  String? type;
  List<RangeFilter> rangeFilters;
  List<ValueFilter> valueFilters;
  // List<FilterType> filterTypes;
}
