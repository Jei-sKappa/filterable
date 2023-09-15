// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: lines_longer_than_80_chars, unnecessary_nullable_for_final_variable_declarations, always_put_required_named_parameters_first, prefer_initializing_formals

part of 'client.dart';

// **************************************************************************
// FilterableGenerator
// **************************************************************************

/// {@template Client}
/// [Client]'s [Filterable]
/// {@endtemplate}
class ClientFilterable extends Filterable {
  /// {@macro Client}
  ClientFilterable({
    /// Parameters used by idFilter to filter [Client]s
    required String id,

    /// Parameters used by nameFilter to filter [Client]s
    required String name,

    /// Parameters used by creationTimeFilter to filter [Client]s
    required DateTime creationTime,
  })  : idFilter = StringFilter(
          id,
        ),
        nameFilter = StringFilter(
          name,
        ),
        creationTimeFilter = DateTimeFilter(
          creationTime,
        );

  /// The filter for [Client]'s id
  final StringFilter idFilter;

  /// The filter for [Client]'s name
  final StringFilter nameFilter;

  /// The filter for [Client]'s creationTime
  final DateTimeFilter creationTimeFilter;

  @override
  List<FilterableField> get filters => [
        FilterableField(
          fieldId: ClientField.id.identifier,
          typeFilterable: idFilter,
        ),
        FilterableField(
          fieldId: ClientField.name.identifier,
          typeFilterable: nameFilter,
        ),
        FilterableField(
          fieldId: ClientField.creationTime.identifier,
          typeFilterable: creationTimeFilter,
        ),
      ];

  /// A wrapper around [ClientFilterable].[filter].
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
    required ClientAdapters<T> adapterGroup,
  }) =>
      super.filter(
        data,
        fieldPath: fieldPath,
        descending: descending,
        adapters: adapterGroup.adapters,
      );

  /// Creates a copy of [ClientFilterable] with
  /// the specified fields replaced with the new values.
  ClientFilterable copyWith({
    String? id,
    String? name,
    DateTime? creationTime,
  }) =>
      ClientFilterable(
        /// It is used (idFilter.value)! because
        /// [idFilter.value] corresponds to [id]
        /// which is managed exclusively by [ClientFilterable]
        /// and, as requested by the constructor, it cannot be null
        id: id ?? (idFilter.value)!,

        /// It is used (nameFilter.value)! because
        /// [nameFilter.value] corresponds to [name]
        /// which is managed exclusively by [ClientFilterable]
        /// and, as requested by the constructor, it cannot be null
        name: name ?? (nameFilter.value)!,

        /// It is used (creationTimeFilter.value)! because
        /// [creationTimeFilter.value] corresponds to [creationTime]
        /// which is managed exclusively by [ClientFilterable]
        /// and, as requested by the constructor, it cannot be null
        creationTime: creationTime ?? (creationTimeFilter.value)!,
      );
}

/// {@template ClientAdapters}
/// [Client]'s [FilterAdapterGroup].
/// Used to generate the safeFilter function.
/// {@endtemplate}
class ClientAdapters<T> extends FilterAdapterGroup<T> {
  /// {@macro ClientAdapters}
  ClientAdapters({
    required this.stringFilterAdapter,
    required this.dateTimeFilterAdapter,
  }) : super([
          stringFilterAdapter,
          dateTimeFilterAdapter,
        ]);

  /// [StringFilter]'s [FilterAdapter]
  final FilterAdapter<T, StringFilter> stringFilterAdapter;

  /// [DateTimeFilter]'s [FilterAdapter]
  final FilterAdapter<T, DateTimeFilter> dateTimeFilterAdapter;
}

/// Fields of Client
enum ClientField {
  /// The id of [Client]
  id('id'),

  /// The name of [Client]
  name('name'),

  /// The creationTime of [Client]
  creationTime('creationTime');

  const ClientField(this.identifier);

  /// The identifier of the field
  final String identifier;
}

/// Extension on [Client] that adds:
/// - [getValueFromField]
/// - [getAllValuesFromFields]
extension ClientGetValueFromFields on Client {
  /// Returns the value of an instance of [Client]
  /// based on a [ClientField]
  dynamic getValueFromField(ClientField field) {
    switch (field) {
      case ClientField.id:
        return id;
      case ClientField.name:
        return name;
      case ClientField.creationTime:
        return creationTime;
    }
  }

  /// Returns a list of values of an instance of
  /// [Client] based on a list of
  /// [ClientField]
  List<dynamic> getAllValuesFromFields(List<ClientField> fields) {
    final values = <dynamic>[];
    for (final field in fields) {
      values.add(getValueFromField(field));
    }

    return values;
  }
}
