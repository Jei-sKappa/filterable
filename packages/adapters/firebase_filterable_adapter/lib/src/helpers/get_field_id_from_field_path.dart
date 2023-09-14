/// Returns the field id from the field path.
/// 
/// Example:
/// ```dart
/// class MyClass {
///  // ...
///  final Task task;
/// }
/// 
/// class Task {
/// // ...
/// final String name;
/// }
/// ```
/// If we want to filter by the `name` inside the `Task` of `MyClass`
/// the Filterable package will pass a field path like this:
/// ```dart
/// ['task', 'name']
/// ```
/// Firebase needs the field path to be a string like this:
/// ```dart
/// 'task.name'
/// ```
/// This function will convert the field path to a string.
String getFieldIdFromFieldPath(List<String> fieldPath) {
  return fieldPath.join('.');
}
