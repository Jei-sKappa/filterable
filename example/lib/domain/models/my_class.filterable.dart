// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: lines_longer_than_80_chars, unnecessary_nullable_for_final_variable_declarations, always_put_required_named_parameters_first, prefer_initializing_formals

part of 'my_class.dart';

// **************************************************************************
// FilterableGenerator
// **************************************************************************

/// Filter of MyClass
class MyClassFilterable extends Filterable {
  MyClassFilterable({
    /// Parameters used by myStringValFilter to filter [MyClass]s
    required String myStringVal,

    /// Parameters used by field2Filter to filter [MyClass]s
    required int field2,

    /// Parameters used by field3Filter to filter [MyClass]s
    required int field3,

    /// Parameters used by field4Filter to filter [MyClass]s
    required int? field4,
  })  : myStringValFilter = StringFilter(
          myStringVal,
        ),
        field2Filter = IntFilter(
          field2,
        ),
        field3Filter = IntFilter(
          field3,
        ),
        field4Filter = IntFilter(
          field4,
        );

  final StringFilter myStringValFilter;

  final IntFilter field2Filter;

  final IntFilter field3Filter;

  final IntFilter field4Filter;

  @override
  List<FilterableField> get filters => [
        FilterableField(
          fieldId: 'myStringVal',
          typeFilterable: myStringValFilter,
        ),
        FilterableField(
          fieldId: 'field2',
          typeFilterable: field2Filter,
        ),
        FilterableField(
          fieldId: 'field3',
          typeFilterable: field3Filter,
        ),
        FilterableField(
          fieldId: 'field4',
          typeFilterable: field4Filter,
        ),
      ];

  MyClassFilterable copyWith({
    String? myStringVal,
    int? field2,
    int? field3,
    int? Function()? field4,
  }) =>
      MyClassFilterable(
        /// It is used (myStringValFilter.value)! because
        /// [myStringValFilter.value] corresponds to [myStringVal]
        /// which is managed exclusively by [MyClassFilterable]
        /// and, as requested by the constructor, it cannot be null
        myStringVal: myStringVal ?? (myStringValFilter.value)!,

        /// It is used (field2Filter.value)! because
        /// [field2Filter.value] corresponds to [field2]
        /// which is managed exclusively by [MyClassFilterable]
        /// and, as requested by the constructor, it cannot be null
        field2: field2 ?? (field2Filter.value)!,

        /// It is used (field3Filter.value)! because
        /// [field3Filter.value] corresponds to [field3]
        /// which is managed exclusively by [MyClassFilterable]
        /// and, as requested by the constructor, it cannot be null
        field3: field3 ?? (field3Filter.value)!,
        field4: field4 != null ? field4() : field4Filter.value,
      );
}
