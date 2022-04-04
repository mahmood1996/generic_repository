import 'package:generic_repository/adapters/persistence/data_mappers/entity_mapper.dart';
import 'package:generic_repository/domain/value_entity.dart';

class ValueEntityMapper<ValueType> extends EntityMapper<ValueEntity<ValueType>> {
  @override
  ValueEntity<ValueType> decode(Map<String, dynamic> data) {
    throw UnimplementedError();
  }

  @override
  Map<String, dynamic> encode(ValueEntity<ValueType> data) {
    throw UnimplementedError();
  }
}