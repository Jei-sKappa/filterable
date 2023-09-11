import 'package:filterable/filterable.dart';
import 'package:filterable_annotation/filterable_annotation.dart';

part 'person.filterable.dart';

@FilterableGen(
  generateFields: true,
  generateGetValueFromFieldsExtension: true,
)
class Person {
  Person({
    required this.name,
    required this.surname,
    required this.age,
    required this.dateOfBirth,
    required this.favoriteColor,
    required this.description,
    required this.ranking,
    this.nickname,
  });

  final String name;

  @FieldKey('surname_of_person')
  final String surname;

  @ValueFilter()
  final int age;

  @ValueFilter()
  @RangeFilter()
  final DateTime dateOfBirth;

  @ValueFilter(defaultValue: "'white'", includeDefaultsInConstructor: false)
  final String favoriteColor;

  @ValueFilter(defaultValue: "'You can write any dart code here'")
  final String description;

  @RangeFilter(defaultMax: '100', defaultMin: '0')
  final int? ranking;

  @ValueFilter()
  final String? nickname;
}
