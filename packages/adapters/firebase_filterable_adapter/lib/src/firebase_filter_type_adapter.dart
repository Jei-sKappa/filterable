import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:filterable/filterable.dart';

abstract class FirebaseFilterTypeAdapter<F extends BaseTypeFilterable>
    extends FilterableTypeAdapter<Query<Map<String, dynamic>>, F> {}
