import 'package:filterable/filterable.dart';
import 'package:filterable_annotation/filterable_annotation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'client.freezed.dart';
part 'client.filterable.dart';

typedef ClientId = String;

@freezed
@FilterableGen(
  generateFields: true,
  generateGetValueFromFieldsExtension: true,
)
class Client with _$Client {
  /// Creates an [Client]
  const factory Client({
    required String id,
    // required ClientId id,
    required String name,
    required DateTime creationTime,
  }) = _Client;

  factory Client.empty({
    required String name,
    required DateTime creationTime,
  }) {
    return Client(
      id: '',
      name: name,
      creationTime: creationTime,
    );
  }
}
