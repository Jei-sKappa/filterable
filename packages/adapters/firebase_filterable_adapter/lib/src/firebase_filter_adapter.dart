import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:filterable/filterable.dart';
import 'package:firebase_filterable_adapter/src/default_adapters/default_adapters.dart';

typedef _FirebaseData = Query<Map<String, dynamic>>;

/// A [FilterAdapter] that use [Query<Map<String, dynamic>>] as data type.
typedef FirebaseFilterAdapter<F extends BaseFilterable>
    = FilterAdapter<_FirebaseData, F>;

/// {@template firebase_filter_adapters}
/// Firebase's default adapters.
/// {@macro default_filter_adapters}
/// {@endtemplate}
class FirebaseFilterableAtapters extends DefaultFilterAdapters<_FirebaseData> {
  /// {@macro firebase_filter_adapters}
  FirebaseFilterableAtapters({
    super.customAdapters,
  }) : super(
          dateFilterAdapter: FirebaseDateTimeFilterAdapter(),
          dateRangeFilterAdapter: FirebaseDateRangeFilterAdapter(),
          intFilterAdapter: FirebaseIntFilterAdapter(),
          intRangeFilterAdapter: FirebaseIntRangeFilterAdapter(),
          stringFilterAdapter: FirebaseStringFilterAdapter(),
        );
}
