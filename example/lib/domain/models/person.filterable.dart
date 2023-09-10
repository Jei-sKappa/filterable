// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'person.dart';

// **************************************************************************
// FilterableGenerator
// **************************************************************************

/// Filter of Person
class PersonFilterable extends Filterable {
  PersonFilterable({
    required String name,
    required String surname,
    required int age,
    required DateTime minDateOfBirth,
    required DateTime maxDateOfBirth,
    required DateTime dateOfBirth,
  })  : nameFilter = StringFilter(
          name,
        ),
        surnameFilter = StringFilter(
          surname,
        ),
        ageFilter = IntFilter(
          age,
        ),
        dateOfBirthRangeFilter = DateTimeRangeFilter(
          minDateOfBirth,
          maxDateOfBirth,
        ),
        dateOfBirthFilter = DateTimeFilter(
          dateOfBirth,
        );

  final StringFilter nameFilter;

  final StringFilter surnameFilter;

  final IntFilter ageFilter;

  final DateTimeRangeFilter dateOfBirthRangeFilter;

  final DateTimeFilter dateOfBirthFilter;

  @override
  List<FilterableField> get filters => [
        FilterableField(
          fieldId: 'name',
          typeFilterable: nameFilter,
        ),
        FilterableField(
          fieldId: 'surname',
          typeFilterable: surnameFilter,
        ),
        FilterableField(
          fieldId: 'age',
          typeFilterable: ageFilter,
        ),
        FilterableField(
          fieldId: 'dateOfBirth',
          typeFilterable: dateOfBirthRangeFilter,
        ),
        FilterableField(
          fieldId: 'dateOfBirth',
          typeFilterable: dateOfBirthFilter,
        ),
      ];
}
