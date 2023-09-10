import 'package:meta/meta_meta.dart';

/// Annotation class to mark a class as filterable
@Target({TargetKind.classType})
class FilterableAnnotation {
  /// Default constructor
  const FilterableAnnotation();
}

/// Annotation to mark a class as filterable
const filterable = FilterableAnnotation();
