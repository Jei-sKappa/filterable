import 'package:example/domain/models/filters/date_filter_without_nullability.dart';
import 'package:example/domain/models/filters/string_strange_suffix_filter.dart';
import 'package:example/domain/models/my_class.dart';
import 'package:filterable/filterable.dart';
import 'package:filterable_annotation/filterable_annotation.dart';

part 'person.filterable.dart';

@FilterableGen(
  generateFields: true,
  generateGetValueFromFieldsExtension: true,
  customFilterTypeSuffix: 'StrangeSuffixFilter',
)
class Person {
  Person({
    required this.name,
    required this.surname,
    required this.age,
    required this.dateOfBirth,
    required this.ranking,
    required this.filterWithStrangeName,
    required this.myClass,
    this.nickname,
  });

  final String name;

  @FieldKey('surname_of_person')
  final String surname;

  @ValueFilter()
  final int age;

  @CustomFilter.named(
    'myCustomDateOfBirthFilter',
    filter: 'DateFilterWithoutNullability',
  )
  @ValueFilter()
  @RangeFilter()
  final DateTime dateOfBirth;

  @RangeFilter()
  @RangeFilter('otherRankingFilter')
  final int? ranking;

  @ValueFilter()
  final String? nickname;

  @CustomFilter()
  final String filterWithStrangeName;

  @CustomFilter('MyClassFilterable')
  final MyClass myClass;
}
