import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:filterable/filterable.dart';
import 'package:firebase_filterable_adapter/src/helpers/firebase_maybe_order_by.dart';

/// TODO: Missing Docs
abstract class FirebaseFilterTypeAdapter<F extends BaseTypeFilterable>
    extends FilterableTypeAdapter<Query<Map<String, dynamic>>, F> {
  @override
  Query<Map<String, dynamic>> getFilteredData(
    Query<Map<String, dynamic>> data,
    String fieldId,
    F filter, {
    required bool descending,
  });
}

/// TODO: Missing Docs
class FirebaseStringFilterAdapter
    extends FirebaseFilterTypeAdapter<StringFilter> {
  @override
  Query<Map<String, dynamic>> getFilteredData(
    Query<Map<String, dynamic>> data,
    String fieldId,
    StringFilter filter, {
    required bool descending,
  }) {
    return _getStringFilteredCollection(
      data,
      fieldId,
      filter,
      descending: descending,
    );
  }
}

/// TODO: Missing Docs
class FirebaseDateRangeFilterAdapter
    extends FirebaseFilterTypeAdapter<DateRangeFilter> {
  @override
  Query<Map<String, dynamic>> getFilteredData(
    Query<Map<String, dynamic>> data,
    String fieldId,
    DateRangeFilter filter, {
    required bool descending,
  }) {
    return _getDateRangeFilteredCollection(
      data,
      fieldId,
      filter,
      descending: descending,
    );
  }
}

Query<Map<String, dynamic>> _getStringFilteredCollection(
  Query<Map<String, dynamic>> collection,
  String field,
  StringFilter stringFilter, {
  required bool descending,
}) {
  var fixedStringQuery = stringFilter.value;

  if (stringFilter.enableTrim) {
    fixedStringQuery = fixedStringQuery.trim();
  }
  // Firebase doesNot support case sensitive search queries
  // if (stringFilter.matchWithLowercase) {
  //   fixedStringQuery = fixedStringQuery.toLowerCase();
  // }

  switch (stringFilter.mode) {
    case StringFilterMode.contains:
    case StringFilterMode.endsWith:
      throw UnimplementedError();
    case StringFilterMode.startsWith:
      return collection
          .where(
            field,
            isGreaterThanOrEqualTo: fixedStringQuery,
          )
          .where(
            field,
            isLessThanOrEqualTo: '$fixedStringQuery\uf7ff',
          )
          .maybeOrderBy(
            field,
            descending: descending,
          );   
  }
}

Query<Map<String, dynamic>> _getDateRangeFilteredCollection(
  Query<Map<String, dynamic>> collection,
  String field,
  DateRangeFilter dateRangeFilter, {
  required bool descending,
}) {
  var query = collection;

  if (dateRangeFilter.min != null) {
    query = query
        .where(
          field,
          isGreaterThanOrEqualTo: dateRangeFilter.min,
        )
        .maybeOrderBy(
          field,
          descending: descending,
        );
  }
  if (dateRangeFilter.max != null) {
    query = query
        .where(
          field,
          isLessThanOrEqualTo: dateRangeFilter.max,
        )
        .maybeOrderBy(
          field,
          descending: descending,
        );
  }

  return query;
}

/// TODO: Missing Docs
class FirebaseFilterableAtapter
    extends FilterableAdapter<Query<Map<String, dynamic>>> {
  /// Creates a new [FirebaseFilterableAtapter]
  FirebaseFilterableAtapter({
    List<FirebaseFilterTypeAdapter<BaseTypeFilterable>>? customAdapters,
  }) : super(
          stringFilterAdapter: FirebaseStringFilterAdapter(),
          dateRangeFilterAdapter: FirebaseDateRangeFilterAdapter(),
          customAdapters: customAdapters,
        );
}
