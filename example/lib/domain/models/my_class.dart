import 'package:filterable/filterable.dart';
import 'package:filterable_annotation/filterable_annotation.dart';

part 'my_class.filterable.dart';

@FilterableGen(
  generateFields: true,
  generateGetValueFromFieldsExtension: true,
)
class MyClass {
  MyClass(
    this.myInt,
    this.myString,
    // this.myList,
    // this.myMap,
    // this.myComplexMap,
    // this.myVeryComplexMap,
  );

  final int myInt;

  @Ignore(ignoreField: false)
  final String myString;
  // final List<String> myList;
  // final Map<String, dynamic> myMap;
  // final Map<String, List<int>> myComplexMap;
  // final Map<String, List<Map<String, int>>> myVeryComplexMap;
}

// void main(){
//   MapOf_StringAndListOf_MapOf_StringAndint___ myFiter;
// }
