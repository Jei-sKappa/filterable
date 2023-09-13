import 'package:meta/meta_meta.dart';

/// Annotation class to mark a class as filterable
@Target({TargetKind.classType})
class FilterableGen {
  /// Default constructor
  const FilterableGen({
    this.generateFields = false,
    this.generateGetValueFromFieldsExtension = false,
    this.customFilterSuffix = 'Filter',
  });

  /// Whether to generate the fields or not
  final bool generateFields;

  /// Whether to generate the extension or not
  /// 
  /// If you want to generate the extension
  /// `generateFields` must be `true
  final bool generateGetValueFromFieldsExtension;


  /// The suffix to use when defining the type
  /// of a CustomFilter when `filter==null`
  /// 
  /// Defaults to: 'Filter'
  /// 
  /// Example:
  /// ```dart
  /// @CustomFilter()
  /// // Will generate a filter of type: 'MyClass<customFilterSuffix>'
  /// final MyClass myString;
  /// ```
  final String customFilterSuffix;
}

/// Annotation to mark a class as filterable
///
/// Example:
/// ```dart
/// @filterable
/// class Person {
///   Person({
///     required this.name,
///     required this.age,
///     required this.dateOfBirth,
///     required this.otherDate,
///   });
///   
///   // If no filter type is specified,
///   // the default is ValueFilter
///   final String name;
/// 
///   final int age;
///   
///   // If a filter type is specifieed the filter
///   // will be only the specified one
///   @RangeFilter()
///   final DateTime dateOfBirth;
/// 
///   // If you want to use multiple filters, you
///   // can annotate the field with multiple
///   // annotation filters
///   @ValueFilter()
///   @RangeFilter()
///   final DateTime otherDate;  
/// }
/// ```
/// 
/// Will generate:
/// ```dart
/// // Filter of Person
/// class PersonFilterable extends Filterable {
///   PersonFilterable({
///     required String name,
///     required int age,
///     required DateTime minDateOfBirth,
///     required DateTime maxDateOfBirth,
///     required DateTime minOtherDate,
///     required DateTime maxOtherDate,
///     required DateTime otherDate,
///   })  : nameFilter = StringFilter(
///           name,
///         ),
///         ageFilter = IntFilter(
///           age,
///         ),
///         dateOfBirthRangeFilter = DateTimeRangeFilter(
///           minDateOfBirth,
///           maxDateOfBirth,
///         ),
///         otherDateRangeFilter = DateTimeRangeFilter(
///           minOtherDate,
///           maxOtherDate,
///         ),
///         otherDateFilter = DateTimeFilter(
///           otherDate,
///         );
/// 
///   final StringFilter nameFilter;
/// 
///   final IntFilter ageFilter;
/// 
///   final DateTimeRangeFilter dateOfBirthRangeFilter;
/// 
///   final DateTimeRangeFilter otherDateRangeFilter;
/// 
///   final DateTimeFilter otherDateFilter;
/// 
///   @override
///   List<FilterableField> get filters => [
///         FilterableField(
///           fieldId: 'name',
///           typeFilterable: nameFilter,
///         ),
///         FilterableField(
///           fieldId: 'age',
///           typeFilterable: ageFilter,
///         ),
///         FilterableField(
///           fieldId: 'dateOfBirth',
///           typeFilterable: dateOfBirthRangeFilter,
///         ),
///         FilterableField(
///           fieldId: 'otherDate',
///           typeFilterable: otherDateRangeFilter,
///         ),
///         FilterableField(
///           fieldId: 'otherDate',
///           typeFilterable: otherDateFilter,
///         ),
///       ];
/// }
/// ```
const filterable = FilterableGen();
