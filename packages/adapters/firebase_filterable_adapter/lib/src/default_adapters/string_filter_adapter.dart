import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:filterable/filterable.dart';
import 'package:firebase_filterable_adapter/src/firebase_filter_adapter.dart';
import 'package:firebase_filterable_adapter/src/helpers/helpers.dart';

/// Firebase's [StringFilter] Adapter
class FirebaseStringFilterAdapter extends FirebaseFilterAdapter<StringFilter> {
  @override
  Query<Map<String, dynamic>> getFilteredData(
    Query<Map<String, dynamic>> data,
    StringFilter filter, {
    required List<String> fieldPath,
    required bool descending,
  }) {
    var fixedStringQuery = filter.value;

    if (filter.enableTrim) {
      fixedStringQuery = fixedStringQuery?.trim();
    }
    // Firebase doesNot support case sensitive search queries
    // if (stringFilter.matchWithLowercase) {
    //   fixedStringQuery = fixedStringQuery.toLowerCase();
    // }

    // CanFilter based on:
    // 1. allowNull: true - "MyQuery" => canFilter: true
    // 2. allowNull: true - "" => canFilter: false
    // 3. allowNull: true - null => canFilter: true
    // 4. allowNull: false - "MyQuery" => canFilter: true
    // 5. allowNull: false - "" => canFilter: false
    // 6. allowNull: false - null => canFilter: false
    // Result:
    // if value is empty cannot filter
    // if value is not empty can filter
    // if value is null and allowNull is true can filter
    // if value is null and allowNull is false cannot filter
    final canFilter = filter.allowNull
        ? (fixedStringQuery?.isNotEmpty ?? true)
        : (fixedStringQuery?.isNotEmpty ?? false);
    if (!canFilter) return data;

    //! Can Filter

    final fieldId = getFieldIdFromFieldPath(fieldPath);

    switch (filter.mode) {
      case StringFilterMode.contains:
      case StringFilterMode.endsWith:
        throw UnimplementedError();
      case StringFilterMode.startsWith:
        return data
            .where(
              fieldId,
              isGreaterThanOrEqualTo: fixedStringQuery,
            )
            .where(
              fieldId,
              isLessThanOrEqualTo: '$fixedStringQuery\uf7ff',
            )
            .maybeOrderBy(
              fieldId,
              descending: descending,
            );
    }
  }
}
