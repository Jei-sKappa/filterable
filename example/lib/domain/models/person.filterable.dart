// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: lines_longer_than_80_chars, unnecessary_nullable_for_final_variable_declarations, always_put_required_named_parameters_first

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
    required DateTime? minDateOfBirth,
    required DateTime? maxDateOfBirth,
    required DateTime dateOfBirth,
    required String favoriteColor,
    String description = defaultDescription,
    int? minRanking = defaultMinRanking,
    int? maxRanking = defaultMaxRanking,
    required String? nickname,
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
        ),
        favoriteColorFilter = StringFilter(
          favoriteColor,
        ),
        descriptionFilter = StringFilter(
          description,
        ),
        rankingRangeFilter = IntRangeFilter(
          minRanking,
          maxRanking,
        ),
        nicknameFilter = StringFilter(
          nickname,
        );

  PersonFilterable.withDefaults({
    required String name,
    required String surname,
    required int age,
    required DateTime? minDateOfBirth,
    required DateTime? maxDateOfBirth,
    required DateTime dateOfBirth,
    required String? nickname,
  }) : this(
          /// Default Values
          favoriteColor: defaultFavoriteColor,
          description: defaultDescription,
          minRanking: defaultMinRanking,
          maxRanking: defaultMaxRanking,

          /// Non-Default Values
          name: name,
          surname: surname,
          age: age,
          minDateOfBirth: minDateOfBirth,
          maxDateOfBirth: maxDateOfBirth,
          dateOfBirth: dateOfBirth,
          nickname: nickname,
        );

  final StringFilter nameFilter;

  final StringFilter surnameFilter;

  final IntFilter ageFilter;

  final DateTimeRangeFilter dateOfBirthRangeFilter;

  final DateTimeFilter dateOfBirthFilter;

  final StringFilter favoriteColorFilter;

  final StringFilter descriptionFilter;

  final IntRangeFilter rankingRangeFilter;

  final StringFilter nicknameFilter;

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
          typeFilterable: dateOfBirthRangeFilter,
        ),
        FilterableField(
          fieldId: PersonField.dateOfBirth.id,
          typeFilterable: dateOfBirthFilter,
        ),
        FilterableField(
          fieldId: PersonField.favoriteColor.id,
          typeFilterable: favoriteColorFilter,
        ),
        FilterableField(
          fieldId: PersonField.description.id,
          typeFilterable: descriptionFilter,
        ),
        FilterableField(
          fieldId: PersonField.ranking.id,
          typeFilterable: rankingRangeFilter,
        ),
        FilterableField(
          fieldId: PersonField.nickname.id,
          typeFilterable: nicknameFilter,
        ),
      ];

  PersonFilterable copyWith({
    String? name,
    String? surname,
    int? age,
    DateTime? Function()? minDateOfBirth,
    DateTime? Function()? maxDateOfBirth,
    DateTime? dateOfBirth,
    String? favoriteColor,
    String? description,
    int? Function()? minRanking,
    int? Function()? maxRanking,
    String? Function()? nickname,
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

        /// It is used (favoriteColorFilter.value)! because
        /// [favoriteColorFilter.value] corresponds to [favoriteColor]
        /// which is managed exclusively by [PersonFilterable]
        /// and, as requested by the constructor, it cannot be null
        favoriteColor: favoriteColor ?? (favoriteColorFilter.value)!,

        /// It is used (descriptionFilter.value)! because
        /// [descriptionFilter.value] corresponds to [description]
        /// which is managed exclusively by [PersonFilterable]
        /// and, as requested by the constructor, it cannot be null
        description: description ?? (descriptionFilter.value)!,
        minRanking: minRanking != null ? minRanking() : rankingRangeFilter.min,
        maxRanking: maxRanking != null ? maxRanking() : rankingRangeFilter.max,
        nickname: nickname != null ? nickname() : nicknameFilter.value,
      );

  /// Default Values for name
  /// No default value requested

  /// Default Values for surname
  /// No default value requested

  /// Default Values for age
  /// No default value requested

  /// Default Values for minDateOfBirth
  /// No default value requested

  /// Default Values for maxDateOfBirth
  /// No default value requested

  /// Default Values for dateOfBirth
  /// No default value requested

  /// Default Values for favoriteColor
  static const String defaultFavoriteColor = 'white';
  bool get isFavoriteColorDefault =>
      favoriteColorFilter.value == defaultFavoriteColor;

  /// Default Values for description
  static const String defaultDescription = 'You can write any dart code here';
  bool get isDescriptionDefault =>
      descriptionFilter.value == defaultDescription;

  /// Default Values for minRanking
  static const int? defaultMinRanking = 0;
  bool get isMinRankingDefault => rankingRangeFilter.min == defaultMinRanking;

  /// Default Values for maxRanking
  static const int? defaultMaxRanking = 100;
  bool get isMaxRankingDefault => rankingRangeFilter.max == defaultMaxRanking;

  /// Default Values for nickname
  /// No default value requested
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

  /// The favoriteColor of [Person]
  favoriteColor('favoriteColor'),

  /// The description of [Person]
  description('description'),

  /// The ranking of [Person]
  ranking('ranking'),

  /// The nickname of [Person]
  nickname('nickname');

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
      case PersonField.favoriteColor:
        return favoriteColor;
      case PersonField.description:
        return description;
      case PersonField.ranking:
        return ranking;
      case PersonField.nickname:
        return nickname;
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
