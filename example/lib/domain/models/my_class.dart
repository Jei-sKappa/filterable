import 'package:filterable/filterable.dart';
import 'package:filterable_annotation/filterable_annotation.dart';

part 'my_class.filterable.dart';

@filterable
class MyClass {
  MyClass(
    this.myStringVal, {
    required this.field2,
    this.field3 = 0,
    this.field4,
  });
  final String myStringVal;
  final int field2;
  final int field3;
  final int? field4;
}
