import 'package:cloud_firestore/cloud_firestore.dart';

/// Extension to add a [maybeOrderBy] method to the [Query] class
extension MaybeOrderBy<T> on Query<T> {
  /// Adds an [orderBy] clause on [field] to the query if it does
  /// not already have one
  Query<T> maybeOrderBy(String field, {required bool descending}) {
    bool hasAlredyOrderedByFieldInQuery(Query query, String field) {
      // queryFormat expected: {orderBy: [[FieldPath([creationTime]), true]]}

      final queryMap = query.parameters;

      if (queryMap.containsKey('orderBy') && queryMap['orderBy'] is List) {
        final orderByList = queryMap['orderBy'] as List;

        for (final orderByItem in orderByList) {
          if (orderByItem is List &&
              orderByItem.isNotEmpty &&
              orderByItem[0] is FieldPath &&
              orderByItem[0].toString() == 'FieldPath([$field])') {
            return true;
          }
        }
      }

      return false;
    }

    if (!hasAlredyOrderedByFieldInQuery(this, field)) {
      return orderBy(
        field,
        descending: descending,
      );
    }

    return this;
  }
}
