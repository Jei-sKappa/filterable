import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:filterable/filterable.dart';
import 'package:firebase_filterable_adapter/src/firebase_filter_adapter.dart';
import 'package:firebase_filterable_adapter/src/helpers/helpers.dart';

/// Firebase's [DateTimeRangeFilter] Adapter
class FirebaseDateRangeFilterAdapter
    extends FirebaseFilterAdapter<DateTimeRangeFilter> {
  @override
  Query<Map<String, dynamic>> getFilteredData(
    Query<Map<String, dynamic>> data,
    DateTimeRangeFilter filter, {
    required List<String> fieldPath,
    required bool descending,
  }) {
    var query = data;

    final fieldId = getFieldIdFromFieldPath(fieldPath);

    if (filter.min != null) {
      query = query
          .where(
            fieldId,
            isGreaterThanOrEqualTo: filter.min,
          )
          .maybeOrderBy(
            fieldId,
            descending: descending,
          );
    }
    if (filter.max != null) {
      query = query
          .where(
            fieldId,
            isLessThanOrEqualTo: filter.max,
          )
          .maybeOrderBy(
            fieldId,
            descending: descending,
          );
    }

    return query;
  }
}
