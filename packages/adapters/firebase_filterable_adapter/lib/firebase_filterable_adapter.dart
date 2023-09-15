/// A Flutter package that helps to use Filterable package with Firebase
library firebase_filterable_adapter;

export 'src/default_adapters/default_adapters.dart';
export 'src/firebase_filter_adapter.dart';
// This is a utility helper class that is useful no only in this package
// so this should be exported by another package
// (something like firebase_helpers)
// export 'src/helpers/firebase_maybe_order_by.dart';
// export 'src/helpers/helpers.dart';
export 'src/helpers/get_field_id_from_field_path.dart';
