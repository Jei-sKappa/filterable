import 'package:meta/meta_meta.dart';

/// [Ignore]
@Target({TargetKind.field})
class Ignore {
  /// Annotation to define the field's key
  const Ignore({this.ignoreField = true});

  /// Whether to ignore also the field
  /// if generated.
  final bool ignoreField;
}
