import 'package:firebase_filterable_adapter/src/default_adapters/default_adapters.dart';
import 'package:firebase_filterable_adapter/src/firebase_filter_adapter.dart';

/// 
List<FirebaseFilterAdapter> firebaseDefaultAdapters = [
  FirebaseDateTimeFilterAdapter(),
  FirebaseDateRangeFilterAdapter(),
  FirebaseIntFilterAdapter(),
  FirebaseIntRangeFilterAdapter(),
  FirebaseStringFilterAdapter(),
];
