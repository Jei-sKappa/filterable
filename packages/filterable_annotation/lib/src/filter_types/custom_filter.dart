part of 'filter_type.dart';

@Target({TargetKind.field})
// TODO: Make F extends Filterable/FilterableType
class CustomFilter implements FilterType {
  const CustomFilter([this.filter]);

  final String? filter;
}
