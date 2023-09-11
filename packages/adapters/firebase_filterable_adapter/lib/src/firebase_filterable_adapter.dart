import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:filterable/filterable.dart';
import 'package:firebase_filterable_adapter/src/default_type_adapters/default_type_adapters.dart';
import 'package:firebase_filterable_adapter/src/firebase_filter_type_adapter.dart';

/// A [DefaultFilterableAdapter] extension that uses
/// [FirebaseFilterTypeAdapter]s to filter data from
/// a [Query<Map<String, dynamic>>]
class FirebaseFilterableAtapter
    extends DefaultFilterableAdapter<Query<Map<String, dynamic>>> {
  /// Creates a new [FirebaseFilterableAtapter]
  FirebaseFilterableAtapter({
    List<FirebaseFilterTypeAdapter<BaseTypeFilterable>>? customAdapters,
  }) : super(
          dateFilterAdapter: FirebaseDateTimeFilterAdapter(),
          dateRangeFilterAdapter: FirebaseDateRangeFilterAdapter(),
          intFilterAdapter: FirebaseIntFilterAdapter(),
          intRangeFilterAdapter: FirebaseIntRangeFilterAdapter(),
          stringFilterAdapter: FirebaseStringFilterAdapter(),
          customAdapters: customAdapters,
        );
}
