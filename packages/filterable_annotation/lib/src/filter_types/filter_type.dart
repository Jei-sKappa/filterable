import 'package:meta/meta_meta.dart';

part 'custom_filter.dart';
part 'range_filter.dart';
part 'value_filter.dart';

/// [FilterType].
sealed class FilterType {
  /// The variable name for the filter.
  /// 
  /// If not provided, it will be autogenerated.
  abstract final String? name;
}
