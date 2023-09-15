// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: lines_longer_than_80_chars, unnecessary_nullable_for_final_variable_declarations, always_put_required_named_parameters_first, prefer_initializing_formals

part of 'person.dart';

// **************************************************************************
// FilterableGenerator
// **************************************************************************

/// {@template Person}
/// [Person]'s [Filterable]
/// {@endtemplate}
class PersonFilterable extends Filterable {
  /// {@macro Person}
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

  /// The filter for [Person]'s name
  final StringFilter nameFilter;

  /// The filter for [Person]'s surname
  final StringFilter surnameFilter;

  /// The filter for [Person]'s age
  final IntFilter ageFilter;

  /// The filter for [Person]'s dateOfBirth
  final DateFilterWithoutNullability myCustomDateOfBirthFilter;

  /// The filter for [Person]'s dateOfBirth
  final DateTimeRangeFilter dateOfBirthRangeFilter;

  /// The filter for [Person]'s dateOfBirth
  final DateTimeFilter dateOfBirthFilter;

  /// The filter for [Person]'s ranking
  final IntRangeFilter rankingRangeFilter;

  /// The filter for [Person]'s ranking
  final IntRangeFilter otherRankingFilter;

  /// The filter for [Person]'s nickname
  final StringFilter nicknameFilter;

  /// The filter for [Person]'s filterWithStrangeName
  final StringStrangeSuffixFilter filterWithStrangeNameFilter;

  /// The filter for [Person]'s myClass
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

  /// A wrapper around [PersonFilterable].[filter].
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
    required PersonAdapters<T> adapterGroup,
  }) =>
      super.filter(
        data,
        fieldPath: fieldPath,
        descending: descending,
        adapters: adapterGroup.adapters,
      );

  /// Creates a copy of [PersonFilterable] with
  /// the specified fields replaced with the new values.
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

/// {@template PersonAdapters}
/// [Person]'s [FilterAdapterGroup].
/// Used to generate the safeFilter function.
/// {@endtemplate}
class PersonAdapters<T> extends FilterAdapterGroup<T> {
  /// {@macro PersonAdapters}
  PersonAdapters({
    required this.stringFilterAdapter,
    required this.intFilterAdapter,
    required this.dateFilterWithoutNullabilityAdapter,
    required this.dateTimeRangeFilterAdapter,
    required this.dateTimeFilterAdapter,
    required this.intRangeFilterAdapter,
    required this.stringStrangeSuffixFilterAdapter,
    required this.myClassFilterableAdapter,
  }) : super([
          stringFilterAdapter,
          intFilterAdapter,
          dateFilterWithoutNullabilityAdapter,
          dateTimeRangeFilterAdapter,
          dateTimeFilterAdapter,
          intRangeFilterAdapter,
          stringStrangeSuffixFilterAdapter,
          myClassFilterableAdapter,
        ]);

  /// [StringFilter]'s [FilterAdapter]
  final FilterAdapter<T, StringFilter> stringFilterAdapter;

  /// [IntFilter]'s [FilterAdapter]
  final FilterAdapter<T, IntFilter> intFilterAdapter;

  /// [DateFilterWithoutNullability]'s [FilterAdapter]
  final FilterAdapter<T, DateFilterWithoutNullability>
      dateFilterWithoutNullabilityAdapter;

  /// [DateTimeRangeFilter]'s [FilterAdapter]
  final FilterAdapter<T, DateTimeRangeFilter> dateTimeRangeFilterAdapter;

  /// [DateTimeFilter]'s [FilterAdapter]
  final FilterAdapter<T, DateTimeFilter> dateTimeFilterAdapter;

  /// [IntRangeFilter]'s [FilterAdapter]
  final FilterAdapter<T, IntRangeFilter> intRangeFilterAdapter;

  /// [StringStrangeSuffixFilter]'s [FilterAdapter]
  final FilterAdapter<T, StringStrangeSuffixFilter>
      stringStrangeSuffixFilterAdapter;

  /// [MyClassFilterable]'s [FilterAdapter]
  final FilterAdapter<T, MyClassFilterable> myClassFilterableAdapter;
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

  /// The identifier of the field
  final String id;
}

/// Extension on [Person] that adds:
/// - [getValueFromField]
/// - [getAllValuesFromFields]
extension PersonGetValueFromFields on Person {
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
