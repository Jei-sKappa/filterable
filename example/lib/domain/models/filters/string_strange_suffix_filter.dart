import 'package:filterable/filterable.dart';

/// A [StringStrangeSuffixFilter].
/// This allows to filter strings
class StringStrangeSuffixFilter implements ValueFilterable<String?> {
  /// The query to filter the string
  @override
  String? value = 'so strange';

  @override
  bool allowNull = false;
}
