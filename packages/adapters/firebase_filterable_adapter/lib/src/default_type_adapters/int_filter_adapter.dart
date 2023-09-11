import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:filterable/filterable.dart';
import 'package:firebase_filterable_adapter/src/firebase_filter_type_adapter.dart';

/// Firebase's [IntFilter] Adapter
class FirebaseIntFilterAdapter extends FirebaseFilterTypeAdapter<IntFilter> {
  @override
  Query<Map<String, dynamic>> getFilteredData(
    Query<Map<String, dynamic>> data,
    String fieldId,
    IntFilter filter, {
    required bool descending,
  }) {
    // CanFilter based on:
    // 1. allowNull: true - value => canFilter: true
    // 3. allowNull: true - null => canFilter: true
    // 4. allowNull: false - value => canFilter: true
    // 6. allowNull: false - null => canFilter: false
    // Result:
    // if allowNull is false and value is null cannot filter
    final canFilter = filter.allowNull || filter.value != null;
    if (!canFilter) return data;

    return data.where(
      fieldId,
      isEqualTo: filter.value,
    );
  }
}
