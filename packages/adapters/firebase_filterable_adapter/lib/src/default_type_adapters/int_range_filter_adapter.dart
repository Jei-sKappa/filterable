import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:filterable/filterable.dart';
import 'package:firebase_filterable_adapter/src/firebase_filter_type_adapter.dart';
import 'package:firebase_filterable_adapter/src/helpers/firebase_maybe_order_by.dart';

/// Firebase's [IntRangeFilter] Adapter
class FirebaseIntRangeFilterAdapter
    extends FirebaseFilterTypeAdapter<IntRangeFilter> {
  @override
  Query<Map<String, dynamic>> getFilteredData(
    Query<Map<String, dynamic>> data,
    String fieldId,
    IntRangeFilter filter, {
    required bool descending,
  }) {
    var query = data;

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
