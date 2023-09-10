import 'package:build/build.dart';
import 'package:filterable_generator/src/filterable_generator.dart';
import 'package:source_gen/source_gen.dart';

/// Builds generators for `build_runner` to run
Builder filterableBuilder(BuilderOptions options) {
  return PartBuilder(
    [FilterableGenerator(/* options.config */)],
    '.filterable.dart',
  );
}
