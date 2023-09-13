import 'package:build/build.dart';
import 'package:filterable_generator/src/filterable_generator.dart';
import 'package:source_gen/source_gen.dart';

/// Builds generators for `build_runner` to run
Builder filterableBuilder(BuilderOptions options) {
  return PartBuilder(
    [FilterableGenerator(/* options.config */)],
    '.filterable.dart',
    header: '''
// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: lines_longer_than_80_chars, unnecessary_nullable_for_final_variable_declarations, always_put_required_named_parameters_first, prefer_initializing_formals
''',
  );
}
