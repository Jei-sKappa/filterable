import 'package:meta/meta_meta.dart';

/// [FieldKey]
@Target({TargetKind.field})
class FieldKey {
  /// Annotation to define the field's key
  const FieldKey(this.key);

  /// The key to be used for the field
  final String key;
}
