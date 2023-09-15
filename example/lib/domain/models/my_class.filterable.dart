// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: lines_longer_than_80_chars, unnecessary_nullable_for_final_variable_declarations, always_put_required_named_parameters_first, prefer_initializing_formals

part of 'my_class.dart';

// **************************************************************************
// FilterableGenerator
// **************************************************************************

/// {@template MyClass}
/// [MyClass]'s [Filterable]
/// {@endtemplate}
class MyClassFilterable extends Filterable {
  /// {@macro MyClass}
  MyClassFilterable({
    /// Parameters used by myIntFilter to filter [MyClass]s
    required int myInt,
  }) : myIntFilter = IntFilter(
          myInt,
        );

  /// The filter for [MyClass]'s myInt
  final IntFilter myIntFilter;

  @override
  List<FilterableField> get filters => [
        FilterableField(
          fieldId: MyClassField.myInt.id,
          typeFilterable: myIntFilter,
        ),
      ];

  /// A wrapper around [MyClassFilterable].[filter].
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
    required MyClassAdapters<T> adapterGroup,
  }) =>
      super.filter(
        data,
        fieldPath: fieldPath,
        descending: descending,
        adapters: adapterGroup.adapters,
      );

  /// Creates a copy of [MyClassFilterable] with
  /// the specified fields replaced with the new values.
  MyClassFilterable copyWith({
    int? myInt,
  }) =>
      MyClassFilterable(
        /// It is used (myIntFilter.value)! because
        /// [myIntFilter.value] corresponds to [myInt]
        /// which is managed exclusively by [MyClassFilterable]
        /// and, as requested by the constructor, it cannot be null
        myInt: myInt ?? (myIntFilter.value)!,
      );
}

/// {@template MyClassAdapters}
/// [MyClass]'s [FilterAdapterGroup].
/// Used to generate the safeFilter function.
/// {@endtemplate}
class MyClassAdapters<T> extends FilterAdapterGroup<T> {
  /// {@macro MyClassAdapters}
  MyClassAdapters({
    required this.intFilterAdapter,
  }) : super([
          intFilterAdapter,
        ]);

  /// [IntFilter]'s [FilterAdapter]
  final FilterAdapter<T, IntFilter> intFilterAdapter;
}

/// Fields of MyClass
enum MyClassField {
  /// The myInt of [MyClass]
  myInt('myInt'),

  /// The myString of [MyClass]
  myString('myString');

  const MyClassField(this.id);

  /// The identifier of the field
  final String id;
}

/// Extension on [MyClass] that adds:
/// - [getValueFromField]
/// - [getAllValuesFromFields]
extension MyClassGetValueFromFields on MyClass {
  /// Returns the value of an instance of [MyClass]
  /// based on a [MyClassField]
  dynamic getValueFromField(MyClassField field) {
    switch (field) {
      case MyClassField.myInt:
        return myInt;
      case MyClassField.myString:
        return myString;
    }
  }

  /// Returns a list of values of an instance of
  /// [MyClass] based on a list of
  /// [MyClassField]
  List<dynamic> getAllValuesFromFields(List<MyClassField> fields) {
    final values = <dynamic>[];
    for (final field in fields) {
      values.add(getValueFromField(field));
    }

    return values;
  }
}
