import 'package:filterable/filterable.dart';
import 'package:filterable_annotation/filterable_annotation.dart';

part 'person.filterable.dart';

@filterable
class Person {
  Person({
    required this.name,
    required this.surname,
    required this.age,
    required this.dateOfBirth,
  });

  final String name;

  final String surname;

  @ValueFilter()
  final int age;

  @ValueFilter()
  @RangeFilter()
  final DateTime dateOfBirth;
}
