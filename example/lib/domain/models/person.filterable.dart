// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: lines_longer_than_80_chars, unnecessary_nullable_for_final_variable_declarations, always_put_required_named_parameters_first, prefer_initializing_formals

part of 'person.dart';

// **************************************************************************
// FilterableGenerator
// **************************************************************************

/// Filter of Person
class PersonFilterable extends Filterable {
  PersonFilterable({
    /// Parameters used by nameFilter to filter [Person]s
    required String name,

    /// Parameters used by surnameFilter to filter [Person]s
    required String surname,

    /// Parameters used by ageFilter to filter [Person]s
    required int age,

    /// Parameters used by myCustomDateOfBirthFilter to filter [Person]s
    required DateFilterWithoutNullability myCustomDateOfBirthFilter,

    /// Parameters used by dateOfBirthRangeFilter to filter [Person]s
    required DateTime? minDateOfBirth,
    required DateTime? maxDateOfBirth,

    /// Parameters used by dateOfBirthFilter to filter [Person]s
    required DateTime dateOfBirth,

    /// Parameters used by rankingRangeFilter to filter [Person]s
    required int? minRanking,
    required int? maxRanking,

    /// Parameters used by otherRankingFilter to filter [Person]s
    required int? minRankingOfOtherRankingFilter,
    required int? maxRankingOfOtherRankingFilter,

    /// Parameters used by nicknameFilter to filter [Person]s
    required String? nickname,

    /// Parameters used by filterWithStrangeNameFilter to filter [Person]s
    required StringStrangeSuffixFilter filterWithStrangeNameFilter,

    /// Parameters used by myClassFilter to filter [Person]s
    required MyClassFilterable myClassFilter,
  })  : nameFilter = StringFilter(
          name,
        ),
        surnameFilter = StringFilter(
          surname,
        ),
        ageFilter = IntFilter(
          age,
        ),
        myCustomDateOfBirthFilter = myCustomDateOfBirthFilter,
        dateOfBirthRangeFilter = DateTimeRangeFilter(
          minDateOfBirth,
          maxDateOfBirth,
        ),
        dateOfBirthFilter = DateTimeFilter(
          dateOfBirth,
        ),
        rankingRangeFilter = IntRangeFilter(
          minRanking,
          maxRanking,
        ),
        otherRankingFilter = IntRangeFilter(
          minRankingOfOtherRankingFilter,
          maxRankingOfOtherRankingFilter,
        ),
        nicknameFilter = StringFilter(
          nickname,
        ),
        filterWithStrangeNameFilter = filterWithStrangeNameFilter,
        myClassFilter = myClassFilter;

  final StringFilter nameFilter;

  final StringFilter surnameFilter;

  final IntFilter ageFilter;

  final DateFilterWithoutNullability myCustomDateOfBirthFilter;

  final DateTimeRangeFilter dateOfBirthRangeFilter;

  final DateTimeFilter dateOfBirthFilter;

  final IntRangeFilter rankingRangeFilter;

  final IntRangeFilter otherRankingFilter;

  final StringFilter nicknameFilter;

  final StringStrangeSuffixFilter filterWithStrangeNameFilter;

  final MyClassFilterable myClassFilter;

  @override
  List<FilterableField> get filters => [
        FilterableField(
          fieldId: PersonField.name.id,
          typeFilterable: nameFilter,
        ),
        FilterableField(
          fieldId: PersonField.surname.id,
          typeFilterable: surnameFilter,
        ),
        FilterableField(
          fieldId: PersonField.age.id,
          typeFilterable: ageFilter,
        ),
        FilterableField(
          fieldId: PersonField.dateOfBirth.id,
          typeFilterable: myCustomDateOfBirthFilter,
        ),
        FilterableField(
          fieldId: PersonField.dateOfBirth.id,
          typeFilterable: dateOfBirthRangeFilter,
        ),
        FilterableField(
          fieldId: PersonField.dateOfBirth.id,
          typeFilterable: dateOfBirthFilter,
        ),
        FilterableField(
          fieldId: PersonField.ranking.id,
          typeFilterable: rankingRangeFilter,
        ),
        FilterableField(
          fieldId: PersonField.ranking.id,
          typeFilterable: otherRankingFilter,
        ),
        FilterableField(
          fieldId: PersonField.nickname.id,
          typeFilterable: nicknameFilter,
        ),
        FilterableField(
          fieldId: PersonField.filterWithStrangeName.id,
          typeFilterable: filterWithStrangeNameFilter,
        ),
        FilterableField(
          fieldId: PersonField.myClass.id,
          typeFilterable: myClassFilter,
        ),
      ];

  PersonFilterable copyWith({
    String? name,
    String? surname,
    int? age,
    DateFilterWithoutNullability? myCustomDateOfBirthFilter,
    DateTime? Function()? minDateOfBirth,
    DateTime? Function()? maxDateOfBirth,
    DateTime? dateOfBirth,
    int? Function()? minRanking,
    int? Function()? maxRanking,
    int? Function()? minRankingOfOtherRankingFilter,
    int? Function()? maxRankingOfOtherRankingFilter,
    String? Function()? nickname,
    StringStrangeSuffixFilter? filterWithStrangeNameFilter,
    MyClassFilterable? myClassFilter,
  }) =>
      PersonFilterable(
        /// It is used (nameFilter.value)! because
        /// [nameFilter.value] corresponds to [name]
        /// which is managed exclusively by [PersonFilterable]
        /// and, as requested by the constructor, it cannot be null
        name: name ?? (nameFilter.value)!,

        /// It is used (surnameFilter.value)! because
        /// [surnameFilter.value] corresponds to [surname]
        /// which is managed exclusively by [PersonFilterable]
        /// and, as requested by the constructor, it cannot be null
        surname: surname ?? (surnameFilter.value)!,

        /// It is used (ageFilter.value)! because
        /// [ageFilter.value] corresponds to [age]
        /// which is managed exclusively by [PersonFilterable]
        /// and, as requested by the constructor, it cannot be null
        age: age ?? (ageFilter.value)!,
        myCustomDateOfBirthFilter:
            myCustomDateOfBirthFilter ?? this.myCustomDateOfBirthFilter,
        minDateOfBirth: minDateOfBirth != null
            ? minDateOfBirth()
            : dateOfBirthRangeFilter.min,
        maxDateOfBirth: maxDateOfBirth != null
            ? maxDateOfBirth()
            : dateOfBirthRangeFilter.max,

        /// It is used (dateOfBirthFilter.value)! because
        /// [dateOfBirthFilter.value] corresponds to [dateOfBirth]
        /// which is managed exclusively by [PersonFilterable]
        /// and, as requested by the constructor, it cannot be null
        dateOfBirth: dateOfBirth ?? (dateOfBirthFilter.value)!,
        minRanking: minRanking != null ? minRanking() : rankingRangeFilter.min,
        maxRanking: maxRanking != null ? maxRanking() : rankingRangeFilter.max,
        minRankingOfOtherRankingFilter: minRankingOfOtherRankingFilter != null
            ? minRankingOfOtherRankingFilter()
            : otherRankingFilter.min,
        maxRankingOfOtherRankingFilter: maxRankingOfOtherRankingFilter != null
            ? maxRankingOfOtherRankingFilter()
            : otherRankingFilter.max,
        nickname: nickname != null ? nickname() : nicknameFilter.value,
        filterWithStrangeNameFilter:
            filterWithStrangeNameFilter ?? this.filterWithStrangeNameFilter,
        myClassFilter: myClassFilter ?? this.myClassFilter,
      );
}

/// Fields of Person
enum PersonField {
  /// The name of [Person]
  name('name'),

  /// The surname of [Person]
  surname('surname_of_person'),

  /// The age of [Person]
  age('age'),

  /// The dateOfBirth of [Person]
  dateOfBirth('dateOfBirth'),

  /// The ranking of [Person]
  ranking('ranking'),

  /// The nickname of [Person]
  nickname('nickname'),

  /// The filterWithStrangeName of [Person]
  filterWithStrangeName('filterWithStrangeName'),

  /// The myClass of [Person]
  myClass('myClass');

  const PersonField(this.id);
  final String id;
}

/// Extension on [Person] that adds:
/// - [getValueFromField]
/// - [getAllValuesFromFields]
extension GetValueFromFields on Person {
  /// Returns the value of an instance of [Person]
  /// based on a [PersonField]
  dynamic getValueFromField(PersonField field) {
    switch (field) {
      case PersonField.name:
        return name;
      case PersonField.surname:
        return surname;
      case PersonField.age:
        return age;
      case PersonField.dateOfBirth:
        return dateOfBirth;
      case PersonField.ranking:
        return ranking;
      case PersonField.nickname:
        return nickname;
      case PersonField.filterWithStrangeName:
        return filterWithStrangeName;
      case PersonField.myClass:
        return myClass;
    }
  }

  /// Returns a list of values of an instance of
  /// [Person] based on a list of
  /// [PersonField]
  List<dynamic> getAllValuesFromFields(List<PersonField> fields) {
    final values = <dynamic>[];
    for (final field in fields) {
      values.add(getValueFromField(field));
    }

    return values;
  }
}
